//
//  LazyTableView_Model.swift
//  EasyTableView
//
//  Created by Myron on 2017/6/17.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

// MARK: - Protocol


/**
 [
    301: Bool, 是否可选状态
    302: CGFloat, Cell 高度
    303: CGFloat, Image Bottom 距离 默认 -8
    ...
 
    310: String UIImage name, 图标0
    311: UIImage, 图标1
    ...
 
    320: String, 标签0
    321: String, 标签1
    ...
 
    330: Bool, 按钮选项
    ...
 
    340: UIFont, 字体
 
    350: Int
 
    360: CGFloat
 
 ]
 */
protocol LazyTableView_Item_Protocol {
    var indexPath: IndexPath! { get set }
    var height: CGFloat? { get set }
    var identifier: String { get set }
    var segue: String? { get set }
    var datas: [Int: Any] { get set }
}

protocol LazyTableView_Model_Protocol {
    var items: [[LazyTableView_Item_Protocol]] { get set }
    var headers: [LazyTableView_Item_Protocol] { get set }
    var footers: [LazyTableView_Item_Protocol] { get set }
    
}

// MARK: - Protocol Extension

extension LazyTableView_Item_Protocol {
    
    func get(tag: Int) -> Any? {
        return datas[tag]
    }
    
}

extension LazyTableView_Model_Protocol {
    
    func items(at: IndexPath) -> LazyTableView_Item_Protocol {
        return items[at.section][at.row]
    }
    
    func headers(at: Int) -> LazyTableView_Item_Protocol? {
        if at < headers.count {
            return headers[at]
        }
        else {
            return nil
        }
    }
    
    func footers(at: Int) -> LazyTableView_Item_Protocol? {
        if at < footers.count {
            return footers[at]
        }
        else {
            return nil
        }
    }
    
}

// MARK: - LazyTableView_Model

class LazyTableView_Item: LazyTableView_Item_Protocol {
    
    var indexPath: IndexPath!
    var height: CGFloat?
    var identifier: String = "0"
    var segue: String?
    
    var datas: [Int: Any] = [:]
    
    init() { }
    
    init(identifier: String, segue: String? = nil, datas: [Int: Any]) {
        self.identifier = identifier
        self.segue = segue
        self.datas = datas
        default_check()
    }
    
    func default_check() {
        // 302: CGFloat, Cell 高度
        if let value = datas[302] as? CGFloat {
            self.height = value
        }
        else if let value = datas[302] as? Int {
            self.height = CGFloat(value)
        }
    }
}

class LazyTableView_Model: LazyTableView_Model_Protocol {
    
    var items: [[LazyTableView_Item_Protocol]] = []
    var headers: [LazyTableView_Item_Protocol] = []
    var footers: [LazyTableView_Item_Protocol] = []
    
    init() { }
    
    init(headers: [LazyTableView_Item_Protocol] = [], footers: [LazyTableView_Item_Protocol] = [], items: [[LazyTableView_Item_Protocol]]) {
        self.headers = headers
        self.footers = footers
        self.items = items
    }
    
}

class LazyModel {
    
    var header: LazyTableView_Item_Protocol?
    var footer: LazyTableView_Item_Protocol?
    var items: [LazyTableView_Item_Protocol] = []
    
    init(header: LazyTableView_Item_Protocol? = nil, footer: LazyTableView_Item_Protocol?, items: [LazyTableView_Item_Protocol]) {
        self.header = header
        self.footer = footer
        self.items  = items
    }
    
    class func model(_ models: LazyModel ...) -> LazyTableView_Model {
        let lazy_model = LazyTableView_Model()
        for model in models {
            lazy_model.headers.append(
                model.header ?? LazyTableView_Item(
                    identifier: LazyTableView.header_identifier,
                    datas: [:]
                )
            )
            
            lazy_model.footers.append(
                model.footer ?? LazyTableView_Item(
                    identifier: LazyTableView.footer_identifier,
                    datas: [:]
                )
            )
            
            lazy_model.items.append(model.items)
        }
        return lazy_model
    }
    
}
