//
//  LazyTableView_Cell.swift
//  EasyTableView
//
//  Created by Myron on 2017/6/17.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

// MARK: - Cell

class LazyTableView_Cell: UITableViewCell {

    @IBInspectable var row_height: CGFloat = -1
    @IBInspectable var segue_identifier: String = LazyTableView.cell_no_segue
    
    weak var tableview: LazyTableView?
    
    func deploy(model: LazyTableView_Item_Protocol) {
        update(model: model)
    }
    
    func update(model: LazyTableView_Item_Protocol) {
        if let visible = model.get(tag: 301) as? Bool {
            self.isUserInteractionEnabled = visible
            self.contentView.alpha = visible ? 1 : 0.5
        }
        
        for subview in contentView.subviews {
            if subview.tag > 309 && subview.tag < 400 {
                if let view = subview as? UILabel {
                    if let text = model.get(tag: view.tag) as? String {
                        view.text = text
                    }
                }
                else if let view = subview as? UIImageView {
                    if let name = model.get(tag: view.tag) as? String {
                        view.image = UIImage(named: name)
                    }
                    else if let image = model.get(tag: view.tag) as? UIImage {
                        view.image = image
                    }
                }
                else if let view = subview as? UISwitch {
                    if let bool = model.get(tag: view.tag) as? Bool {
                        view.isOn = bool
                    }
                    else if let text = model.get(tag: view.tag) as? String {
                        switch text.lowercased() {
                        case "yes", "open", "1", "true", "on":
                            view.isOn = true
                        default:
                            view.isOn = false
                        }
                    }
                    else if let number = model.get(tag: view.tag) as? Int {
                        view.isOn = number == 1
                    }
                }
            }
        }
    }
    
}
