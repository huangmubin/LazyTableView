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
    var index: IndexPath!
    
    var layer_top: CAShapeLayer = CAShapeLayer()
    var layer_center: CAShapeLayer = CAShapeLayer()
    var layer_bottom: CAShapeLayer = CAShapeLayer()
    
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
        select_layers()
        
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
                let tag_suffix = subview.tag % 10
                
                if let view = subview as? UILabel {
                    if let text = model.get(tag: view.tag) as? String {
                        view.text = text
                    }
                    if let font = model.get(tag: 340 + tag_suffix) as? UIFont {
                        view.font = font
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
                    view.addTarget(
                        self, 
                        action: #selector(subview_actions(_:)),
                        for: .valueChanged
                    )
                    
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
                else if let view = subview as? UIButton {
                    view.addTarget(
                        self,
                        action: #selector(subview_actions(_:)),
                        for: .touchUpInside
                    )
                    if let name = model.get(tag: 310 + tag_suffix) as? String {
                        view.setImage(UIImage(named: name), for: .normal)
                    }
                    if let text = model.get(tag: 320 + tag_suffix) as? String {
                        view.setTitle(text, for: .normal)
                    }
                    if let font = model.get(tag: 340 + tag_suffix) as? UIFont {
                        view.titleLabel?.font = font
                    }
                }
            }
        }
    }
    
    func subview_actions(_ sender: UIView) {
        tableview?.lazy_tableView(
            cell: self,
            view_Action: sender,
            at: index
        )
    }
    
    override var frame: CGRect {
        didSet {
            update_layers()
        }
    }
    override var bounds: CGRect {
        didSet {
            update_layers()
        }
    }
    
}

extension LazyTableView_Cell {
    
    func select_layers() {
        layer_top.removeFromSuperlayer()
        layer_center.removeFromSuperlayer()
        layer_bottom.removeFromSuperlayer()
        
        if let count = tableview?.model?.items[index.section].count {
            if count == 1 {
                layer.addSublayer(layer_center)
            }
            else if index.row == 0 {
                layer.addSublayer(layer_top)
            }
            else if index.row == count - 1 {
                layer.addSublayer(layer_bottom)
            }
        }
    }
    
    func update_layers() {
        if let corner = tableview?.section_corner,
           let color = tableview?.backgroundColor?.cgColor {
            if corner != 0 {
                let x_l: CGFloat = 0
                let x_c: CGFloat = bounds.width / 2
                let x_r: CGFloat = bounds.width
                let y_t: CGFloat = 0
                let y_b: CGFloat = bounds.height
                let x_p1: CGFloat = corner
                let x_p2: CGFloat = bounds.width - corner
                let y_p1: CGFloat = corner
                let y_p2: CGFloat = bounds.height - corner
                
                let _ = {
                    let path = UIBezierPath()
                    path.move(to: CGPoint(x: x_c, y: y_t))
                    path.addLine(to: CGPoint(x: x_l, y: y_t))
                    path.addLine(to: CGPoint(x: x_l, y: y_b))
                    path.addLine(to: CGPoint(x: x_r, y: y_b))
                    path.addLine(to: CGPoint(x: x_r, y: y_t))
                    path.addLine(to: CGPoint(x: x_c, y: y_t))
                    
                    path.addLine(to: CGPoint(x: x_p2, y: y_t))
                    path.addArc(
                        withCenter: CGPoint(x: x_p2, y: y_p1),
                        radius: corner,
                        startAngle: CGFloat.pi * 1.5,
                        endAngle: CGFloat.pi * 0,
                        clockwise: true
                    )
                    path.addLine(to: CGPoint(x: x_r, y: y_b))
                    path.addLine(to: CGPoint(x: x_l, y: y_b))
                    path.addLine(to: CGPoint(x: x_l, y: y_p1))
                    path.addArc(
                        withCenter: CGPoint(x: x_p1, y: y_p1),
                        radius: corner,
                        startAngle: CGFloat.pi * 1,
                        endAngle: CGFloat.pi * 1.5,
                        clockwise: true
                    )
                    path.addLine(to: CGPoint(x: x_c, y: y_t))
                    
                    layer_top.path = path.cgPath
                    layer_top.fillColor = color
                }()
                let _ = {
                    let path = UIBezierPath()
                    path.move(to: CGPoint(x: x_c, y: y_t))
                    path.addLine(to: CGPoint(x: x_l, y: y_t))
                    path.addLine(to: CGPoint(x: x_l, y: y_b))
                    path.addLine(to: CGPoint(x: x_r, y: y_b))
                    path.addLine(to: CGPoint(x: x_r, y: y_t))
                    path.addLine(to: CGPoint(x: x_c, y: y_t))
                    
                    path.addLine(to: CGPoint(x: x_p2, y: y_t))
                    path.addArc(
                        withCenter: CGPoint(x: x_p2, y: y_p1),
                        radius: corner,
                        startAngle: CGFloat.pi * 1.5,
                        endAngle: CGFloat.pi * 0,
                        clockwise: true
                    )
                    path.addLine(to: CGPoint(x: x_r, y: y_p2))
                    path.addArc(
                        withCenter: CGPoint(x: x_p2, y: y_p2),
                        radius: corner,
                        startAngle: CGFloat.pi * 0,
                        endAngle: CGFloat.pi * 0.5,
                        clockwise: true
                    )
                    path.addLine(to: CGPoint(x: x_p1, y: y_b))
                    path.addArc(
                        withCenter: CGPoint(x: x_p1, y: y_p2),
                        radius: corner,
                        startAngle: CGFloat.pi * 0.5,
                        endAngle: CGFloat.pi * 1,
                        clockwise: true
                    )
                    path.addLine(to: CGPoint(x: x_l, y: y_p1))
                    path.addArc(
                        withCenter: CGPoint(x: x_p1, y: y_p1),
                        radius: corner,
                        startAngle: CGFloat.pi * 1,
                        endAngle: CGFloat.pi * 1.5,
                        clockwise: true
                    )
                    path.addLine(to: CGPoint(x: x_c, y: y_t))
                    
                    layer_center.path = path.cgPath
                    layer_center.fillColor = color
                }()
                let _ = {
                    let path = UIBezierPath()
                    path.move(to: CGPoint(x: x_c, y: y_t))
                    path.addLine(to: CGPoint(x: x_l, y: y_t))
                    path.addLine(to: CGPoint(x: x_l, y: y_b))
                    path.addLine(to: CGPoint(x: x_r, y: y_b))
                    path.addLine(to: CGPoint(x: x_r, y: y_t))
                    path.addLine(to: CGPoint(x: x_c, y: y_t))
                    
                    path.addLine(to: CGPoint(x: x_r, y: y_t))
                    path.addLine(to: CGPoint(x: x_r, y: y_p2))
                    path.addArc(
                        withCenter: CGPoint(x: x_p2, y: y_p2),
                        radius: corner,
                        startAngle: CGFloat.pi * 0,
                        endAngle: CGFloat.pi * 0.5,
                        clockwise: true
                    )
                    path.addLine(to: CGPoint(x: x_p1, y: y_b))
                    path.addArc(
                        withCenter: CGPoint(x: x_p1, y: y_p2),
                        radius: corner,
                        startAngle: CGFloat.pi * 0.5,
                        endAngle: CGFloat.pi * 1,
                        clockwise: true
                    )
                    path.addLine(to: CGPoint(x: x_l, y: y_t))
                    path.addLine(to: CGPoint(x: x_c, y: y_t))
                    
                    layer_bottom.path = path.cgPath
                    layer_bottom.fillColor = color
                }()
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
