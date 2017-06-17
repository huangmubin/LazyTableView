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
    ...
 
    310: String UIImage name, 图标0
    311: UIImage, 图标1
    ...
 
    320: String, 标签0
    321: String, 标签1
    ...
 
    330: Bool, 按钮选项
    ...
 
    340: Int
 
    350: CGFloat, 小数
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
    
}

// MARK: - LazyTableView_Model

class LazyTableView_Item: LazyTableView_Item_Protocol {
    
    var indexPath: IndexPath!
    var height: CGFloat?
    var identifier: String = "0"
    var segue: String?
    
    var datas: [Int: Any] = [:]
    
    init() {
        
    }
    
    init(identifier: String, datas: [Int: Any]) {
        self.identifier = identifier
        self.datas = datas
    }
    
}

class LazyTableView_Model: LazyTableView_Model_Protocol {
    
    var items: [[LazyTableView_Item_Protocol]] = []
    
    init() {
        
    }
    
    init(items: [[LazyTableView_Item_Protocol]]) {
        self.items = items
    }
    
    class func Model() -> LazyTableView_Model {
        let model = LazyTableView_Model()
        for sec in 0 ..< 1 {
            var item_rows = [LazyTableView_Item_Protocol]()
            for row in 0 ..< 1 {
                let item = LazyTableView_Item()
                item.identifier = "Cell1"
                item.datas = lazy_datas[sec][row]
                item_rows.append(item)
            }
            model.items.append(item_rows)
        }
        return model
    }
}

