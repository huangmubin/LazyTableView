//
//  ViewController.swift
//  LazyTableView
//
//  Created by Myron on 2017/6/17.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.model = LazyTableView_Model.default_model()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var tableView: LazyTableView!

}

extension ViewController: LazyTableView_Delegate_Protocol {
    
    func lazy(tableview: LazyTableView, load cell: LazyTableView_Cell, at indexPath: IndexPath) {
        
    }
    
    func lazy(tableview: LazyTableView, display cell: LazyTableView_Cell, at indexPath: IndexPath) {
        
    }
    
    func lazy(tableview: LazyTableView, didSelected cell: LazyTableView_Cell, at indexPath: IndexPath) {
        print("Lazy TableView did Selected Cell at \(indexPath)")
    }
    
    func lazy(tableview: LazyTableView, cell: LazyTableView_Cell, viewAction view: UIView, at indexPath: IndexPath) {
        print("Lazy TableView View tag \(view.tag) Action Cell at \(indexPath)")
    }
    
}
