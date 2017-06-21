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
        if model.identifier == LazyTableView.cell_identifier
        || model.identifier == LazyTableView.header_identifier
        || model.identifier == LazyTableView.footer_identifier {
            if contentView.viewWithTag(310) == nil {
                deploy_default_subviews()
            }
        }
        update(model: model)
    }
    
    func update(model: LazyTableView_Item_Protocol) {
        if let visible = model.get(tag: 301) as? Bool {
            self.isUserInteractionEnabled = visible
            self.contentView.alpha = visible ? 1 : 0.5
        }
        else {
            self.isUserInteractionEnabled = true
            self.contentView.alpha = 1
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

extension LazyTableView_Cell {
    
    func deploy_default_subviews() {
        self.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        let image = UIImageView()
        let label_name = UILabel()
        let label_detail = UILabel()
        
        let _ = {
            image.tag = 310
            contentView.addSubview(image)
            image.translatesAutoresizingMaskIntoConstraints = false
            let top = NSLayoutConstraint(
                item: image,
                attribute: .top,
                relatedBy: .equal,
                toItem: self.contentView,
                attribute: .top,
                multiplier: 1,
                constant: 8
            )
            let bottom = NSLayoutConstraint(
                item: image,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: self.contentView,
                attribute: .bottom,
                multiplier: 1,
                constant: -8
            )
            let leading = NSLayoutConstraint(
                item: image,
                attribute: .leading,
                relatedBy: .equal,
                toItem: self.contentView,
                attribute: .leading,
                multiplier: 1,
                constant: 20
            )
            let equal = NSLayoutConstraint(
                item: image,
                attribute: .width,
                relatedBy: .equal,
                toItem: image,
                attribute: .height,
                multiplier: 1,
                constant: 0
            )
            self.contentView.addConstraints([top, bottom, leading, equal])
        }()
        
        let _ = {
            label_name.tag = 320
            contentView.addSubview(label_name)
            label_name.translatesAutoresizingMaskIntoConstraints = false
            let centerY = NSLayoutConstraint(
                item: label_name,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: self.contentView,
                attribute: .centerY,
                multiplier: 1,
                constant: 0
            )
            let leading = NSLayoutConstraint(
                item: label_name,
                attribute: .leading,
                relatedBy: .equal,
                toItem: image,
                attribute: .trailing,
                multiplier: 1,
                constant: 20
            )
            self.contentView.addConstraints([centerY, leading])
        }()
        
        
        let _ = {
            label_detail.tag = 321
            contentView.addSubview(label_detail)
            label_detail.translatesAutoresizingMaskIntoConstraints = false
            let centerY = NSLayoutConstraint(
                item: label_detail,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: self.contentView,
                attribute: .centerY,
                multiplier: 1,
                constant: 0
            )
            let trailing = NSLayoutConstraint(
                item: label_detail,
                attribute: .trailing,
                relatedBy: .equal,
                toItem: self.contentView,
                attribute: .trailing,
                multiplier: 1,
                constant: -8
            )
            self.contentView.addConstraints([centerY, trailing])
        }()
    }
    
}
