//
//  Data.swift
//  EasyTableView
//
//  Created by Myron on 2017/6/17.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

extension LazyTableView_Model {
    
    class func default_model() -> LazyTableView_Model {
        return LazyTableView_Model(
            items: [
                [
                    LazyTableView_Item(
                        identifier: "Cell1",
                        datas: [
                            310: "image",
                            320: "黄穆斌",
                            321: "App, Lazy Table View, Model, Data, Others ..."
                        ]
                    ),
                    LazyTableView_Item(
                        identifier: "Cell1",
                        datas: [
                            310: "image",
                            320: "黄穆斌 2",
                            321: "App, Lazy Table View, Model, Data, Others ..."
                        ]
                    ),
                ],
            ]
        )
    }
    
}
