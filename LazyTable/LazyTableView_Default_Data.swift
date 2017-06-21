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
                        320: "Custom Section 1",
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
            )
        )
    }
    
//    class func default_model() -> LazyTableView_Model {
//        return LazyTableView_Model(
//            headers: [
//                LazyTableView_Item(
//                    identifier: LazyTableView.header_identifier,
//                    datas: [
//                        320: "Developer 0",
//                        ]
//                ),
//                LazyTableView_Item(
//                    identifier: LazyTableView.header_identifier,
//                    datas: [
//                        320: "Developer 0",
//                        ]
//                ),
//                LazyTableView_Item(
//                    identifier: LazyTableView.header_identifier,
//                    datas: [
//                        320: "Developer 2",
//                        ]
//                ),
//            ],
//            footers: [
//                LazyTableView_Item(
//                    identifier: LazyTableView.footer_identifier,
//                    datas: [
//                        320: "Developer 0",
//                        ]
//                ),
//                LazyTableView_Item(
//                    identifier: LazyTableView.footer_identifier,
//                    datas: [
//                        320: "Developer 1",
//                        ]
//                ),
//                LazyTableView_Item(
//                    identifier: LazyTableView.header_identifier,
//                    datas: [
//                        320: "Developer 2",
//                        ]
//                ),
//            ],
//            items: [
//                [
//                    LazyTableView_Item(
//                        identifier: LazyTableView.cell_identifier,
//                        segue: nil,
//                        datas: [
//                            310: "image1",
//                            320: "Default 0",
//                            321: "Status"
//                        ]
//                    ),
//                    LazyTableView_Item(
//                        identifier: LazyTableView.cell_identifier,
//                        segue: nil,
//                        datas: [
//                            310: "image2",
//                            320: "Default 1",
//                            321: "Status"
//                        ]
//                    ),
//                    LazyTableView_Item(
//                        identifier: LazyTableView.cell_identifier,
//                        segue: nil,
//                        datas: [
//                            301: false,
//                            310: "image3",
//                            320: "Default 2",
//                            321: "Status"
//                        ]
//                    ),
//                ],
//                [
//                    LazyTableView_Item(
//                        identifier: "LazyTableView_Cell_0",
//                        segue: nil,
//                        datas: [
//                            310: "image1",
//                            320: "Developer 0",
//                            321: "App, Lazy Table View, Model, Data, Others ..."
//                        ]
//                    ),
//                    LazyTableView_Item(
//                        identifier: "LazyTableView_Cell_0",
//                        segue: "LazyTableView_Cell_1",
//                        datas: [
//                            310: "image2",
//                            320: "Developer 1",
//                            321: "App, Lazy Table View, Model, Data, Others ..."
//                        ]
//                    ),
//                    LazyTableView_Item(
//                        identifier: "LazyTableView_Cell_0",
//                        segue: "LazyTableView_Cell_1",
//                        datas: [
//                            301: false,
//                            310: "image3",
//                            320: "Developer 2",
//                            321: "App, Lazy Table View, Model, Data, Others ..."
//                        ]
//                    ),
//                ],
//                [
//                    LazyTableView_Item(
//                        identifier: "LazyTableView_Cell_1",
//                        segue: nil,
//                        datas: [
//                            310: "image1",
//                            320: "Set 0",
//                            321: "开启"
//                        ]
//                    ),
//                    LazyTableView_Item(
//                        identifier: "LazyTableView_Cell_1",
//                        segue: nil,
//                        datas: [
//                            310: "image2",
//                            320: "Set 1",
//                            321: "开启"
//                        ]
//                    ),
//                    LazyTableView_Item(
//                        identifier: "LazyTableView_Cell_1",
//                        segue: nil,
//                        datas: [
//                            301: false,
//                            310: "image3",
//                            320: "Set 2",
//                            321: "开启"
//                        ]
//                    ),
//                ],
//            ]
//        )
//    }
    
}
