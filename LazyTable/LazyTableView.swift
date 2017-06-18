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
    @objc optional func lazy(tableview: LazyTableView, didSelect cell: LazyTableView_Cell, at indexPath: IndexPath)
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
        self.register(
            LazyTableView_Cell.self,
            forCellReuseIdentifier: "LazyTableView_Header_Default"
        )
        self.register(
            LazyTableView_Cell.self,
            forCellReuseIdentifier: "LazyTableView_Footer_Default"
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
    
    // MARK: Header Footer
    
    @IBInspectable var header_height: CGFloat = 0
    @IBInspectable var header_color: UIColor  = UIColor.clear
    
    @IBInspectable var footer_height: CGFloat = 0
    @IBInspectable var footer_color: UIColor  = UIColor.clear
    
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
        if cell.segue_identifier != "no_segue_identifier" && item.segue == nil {
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.yellow
        return view
    }
}

// MARK: - UITableView Delegate

extension LazyTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return model?.items(at: indexPath).height ?? tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.header_height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.footer_height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = model?.items(at: indexPath) {
            if let segue = item.segue {
                controller()?.performSegue(withIdentifier: segue, sender: item)
            }
        }
    }
    
}

// MARK: - Tools

extension LazyTableView {

    /** 获取 View 所在 UIViewController */
    func controller() -> UIViewController? {
        var next: UIView? = superview
        while next != nil {
            if next?.next?.isKind(of: UIViewController.self) == true {
                return next?.next as? UIViewController
            }
            next = next?.superview
        }
        return nil
    }
    
}
