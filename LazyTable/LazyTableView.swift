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
            forCellReuseIdentifier: LazyTableView.cell_identifier
        )
        self.register(
            LazyTableView_HeaderFooter.self,
            forCellReuseIdentifier: LazyTableView.header_identifier
        )
        self.register(
            LazyTableView_HeaderFooter.self,
            forCellReuseIdentifier: LazyTableView.footer_identifier
        )
        self.dataSource = self
        self.delegate   = self
    }
    
    // MARK: - Data
    
    static let cell_identifier = "LazyTableView_Cell_Default"
    static let header_identifier = "LazyTableView_Header_Default"
    static let footer_identifier = "LazyTableView_Footer_Default"
    static let cell_no_segue = "no_segue_identifier"
    
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
        let cell = tableView.dequeueReusableCell(
            withIdentifier: model?.items(at: indexPath).identifier ?? LazyTableView.cell_identifier,
            for: indexPath
        ) as! LazyTableView_Cell
        cell.tableview = self
        
        if var item = model?.items(at: indexPath) {
            item.indexPath = indexPath
            if cell.row_height != -1 {
                item.height = cell.row_height
            }
            if cell.segue_identifier != LazyTableView.cell_no_segue && item.segue == nil {
                item.segue = cell.segue_identifier
            }
            cell.deploy(model: item)
        }
        
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
        let view: LazyTableView_HeaderFooter = tableView.dequeueReusableCell(
            withIdentifier: model?.headers(at: section)?.identifier ?? LazyTableView.header_identifier
        ) as! LazyTableView_HeaderFooter
        view.backgroundColor = header_color
        
        if let item = model?.headers(at: section) {
            view.deploy(model: item)
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? LazyTableView_HeaderFooter,
            let item = model?.headers(at: section) {
            view.backgroundColor = header_color
            view.update(model: item)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view: LazyTableView_HeaderFooter = tableView.dequeueReusableCell(
            withIdentifier: model?.footers(at: section)?.identifier ?? LazyTableView.footer_identifier
        ) as! LazyTableView_HeaderFooter
        view.backgroundColor = footer_color
        
        if let item = model?.footers(at: section) {
            view.deploy(model: item)
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let view = view as? LazyTableView_HeaderFooter,
            let item = model?.footers(at: section) {
            view.backgroundColor = footer_color
            view.update(model: item)
        }
    }
}

// MARK: - UITableView Delegate

extension LazyTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return model?.items(at: indexPath).height ?? tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return model?.headers(at: section)?.height ?? header_height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return model?.footers(at: section)?.height ??  footer_height
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
