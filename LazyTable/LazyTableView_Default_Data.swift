//
//  Data.swift
//  EasyTableView
//
//  Created by Myron on 2017/6/17.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit



extension LazyTableView_Model {
    /*
    301: Bool, 是否可选状态
    302: CGFloat, Cell 高度
    ...
    310: String - UIImage name, 图标
    320: String - Title text 标签
    330: Bool - Switch value 按钮选项
    340: UIFont - Button or title Font 字体
    350: Int
    360: CGFloat
    */
    class func default_model() -> LazyTableView_Model {
        return LazyModel.model(
            LazyModel(
                header: LazyTableView_Item(
                    identifier: LazyTableView.header_identifier,
                    datas: [
                        302: 40,
                        320: "Default Header",
                    ]
                ),
                footer: LazyTableView_Item(
                    identifier: LazyTableView.header_identifier,
                    datas: [
                        302: 40,
                        320: "Default Footer",
                    ]
                ),
                items: [
                    LazyTableView_Item(
                        identifier: LazyTableView.cell_identifier,
                        segue: nil,
                        datas: [
                            310: "image1",
                            320: "Default Cell",
                            321: "Status"
                        ]
                    ),
                    LazyTableView_Item(
                        identifier: LazyTableView.cell_identifier,
                        segue: nil,
                        datas: [
                            301: false,
                            310: "image2",
                            320: "Default Cell",
                            321: "Status"
                        ]
                    )
                ]
            ),
            LazyModel(
                header: LazyTableView_Item(
                    identifier: LazyTableView.header_identifier,
                    datas: [
                        320: "Default Section 1",
                        ]
                ),
                footer: nil,
                items: [
                    LazyTableView_Item(
                        identifier: "LazyTableView_Cell_0",
                        segue: nil,
                        datas: [
                            310: "image1",
                            320: "Default Cell",
                            321: "Status"
                        ]
                    ),
                    LazyTableView_Item(
                        identifier: "LazyTableView_Cell_0",
                        segue: nil,
                        datas: [
                            301: false,
                            310: "image2",
                            320: "Default Cell",
                            321: "Status"
                        ]
                    )
                ]
            ),
            LazyModel(
                header: LazyTableView_Item(
                    identifier: LazyTableView.header_identifier,
                    datas: [
                        320: "Default Section 2",
                        ]
                ),
                footer: nil,
                items: [
                    LazyTableView_Item(
                        identifier: "LazyTableView_Cell_1",
                        segue: nil,
                        datas: [
                            310: "image1",
                            320: "Default Cell",
                            321: "Status"
                        ]
                    ),
                    LazyTableView_Item(
                        identifier: "LazyTableView_Cell_1",
                        segue: nil,
                        datas: [
                            301: false,
                            310: "image2",
                            320: "Default Cell",
                            321: "Status"
                        ]
                    )
                ]
            ),
            LazyModel(
                header: LazyTableView_Item(
                    identifier: LazyTableView.header_identifier,
                    datas: [
                        320: "Default Section 3",
                        ]
                ),
                footer: nil,
                items: [
                    LazyTableView_Item(
                        identifier: "LazyTableView_Cell_2",
                        segue: nil,
                        datas: [
                            310: "image1",
                            320: "Default Cell",
                            330: false,
                        ]
                    ),
                    LazyTableView_Item(
                        identifier: "LazyTableView_Cell_2",
                        segue: nil,
                        datas: [
                            301: false,
                            310: "image2",
                            320: "Default Cell",
                            330: true,
                        ]
                    )
                ]
            ),
            LazyModel(
                header: LazyTableView_Item(
                    identifier: LazyTableView.header_identifier,
                    datas: [
                        320: "Default Section 4",
                        ]
                ),
                footer: nil,
                items: [
                    LazyTableView_Item(
                        identifier: "LazyTableView_Cell_3",
                        segue: nil,
                        datas: [
                            340: "Default Button",
                            ]
                    ),
                    LazyTableView_Item(
                        identifier: "LazyTableView_Cell_3",
                        segue: nil,
                        datas: [
                            340: "Default Button"
                            ]
                    )
                ]
            )
        )
    }
    
}
