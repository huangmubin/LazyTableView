//
//  EasyTableView.swift
//  EasyTableView
//
//  Created by Myron on 2017/6/17.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

// MARK: - Delegate

@objc protocol LazyTableView_Delegate_Protocol {
    @objc optional func lazy(tableview: LazyTableView, load cell: LazyTableView_Cell, at indexPath: IndexPath)
    @objc optional func lazy(tableview: LazyTableView, display cell: LazyTableView_Cell, at indexPath: IndexPath)
}

// MARK: - Lazy Table View

class LazyTableView: UITableView {
    
    // MARK: - Init
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        deploy()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        deploy()
    }
    
    private func deploy() {
        self.register(
            LazyTableView_Cell.self,
            forCellReuseIdentifier: "LazyTableView_Cell_Default"
        )
        self.dataSource = self
        self.delegate   = self
    }
    
    // MARK: - Data
    
    var model: LazyTableView_Model_Protocol?
    func get(item: IndexPath) -> LazyTableView_Item_Protocol? {
        return model?.items(at: item)
    }
    
    @IBOutlet var delegate_link: NSObject?
    var lazy_delegate: LazyTableView_Delegate_Protocol? {
        return delegate_link as? LazyTableView_Delegate_Protocol
    }
}

// MARK: - UITableView DataSource

extension LazyTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.items[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var item = model?.items(at: indexPath) else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "LazyTableView_Cell_Default",
                for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: item.identifier,
            for: indexPath
        ) as! LazyTableView_Cell
        
        item.indexPath = indexPath
        if cell.row_height != -1 {
            item.height = cell.row_height
        }
        if cell.segue_identifier != "no_segue_identifier" {
            item.segue = cell.segue_identifier
        }
        
        cell.tableview = self
        cell.deploy(model: item)
        
        lazy_delegate?.lazy?(
            tableview: self,
            load: cell,
            at: indexPath
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? LazyTableView_Cell,
            let item = model?.items(at: indexPath) {
            cell.update(model: item)
            lazy_delegate?.lazy?(
                tableview: self,
                load: cell,
                at: indexPath
            )
        }
    }
    
}

// MARK: - UITableView Delegate

extension LazyTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return model?.items(at: indexPath).height ?? tableView.rowHeight
    }
    
}
