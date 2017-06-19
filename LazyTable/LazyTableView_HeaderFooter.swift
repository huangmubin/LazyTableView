//
//  LazyTableView_HeaderFooter.swift
//  LazyTableView
//
//  Created by 黄穆斌 on 2017/6/18.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

class LazyTableView_HeaderFooter: LazyTableView_Cell {

    override func deploy_default_subviews() {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.tag = 320
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        let leading = NSLayoutConstraint(
            item: label,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self.contentView,
            attribute: .leading,
            multiplier: 1,
            constant: 20
        )
        let centerY = NSLayoutConstraint(
            item: label,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self.contentView,
            attribute: .centerY,
            multiplier: 1,
            constant: 0
        )
        contentView.addConstraints([leading, centerY])
    }
}
