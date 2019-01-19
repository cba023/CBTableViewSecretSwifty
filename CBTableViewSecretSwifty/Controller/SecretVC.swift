//
//  SecretVC.swift
//  CBTableViewSecretSwifty
//
//  Created by flowerflower on 2019/1/19.
//  Copyright © 2019 Creater. All rights reserved.
//

import UIKit

class SecretVC: UIViewController {

    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Secret"
    }
    
    func configUI() {
        self.tableView = UITableView(frame: self.view.bounds, style: .grouped)
        self.view.addSubview(tableView)
    }
    
    func configData() {
//        let dicNews = Util.getJsonData(from: "News", fileType: "json")
//        let dicPerson = Util.getJsonData(from: "Person", fileType: "json")
//        let dicAppliances = Util.getJsonData(from: "Appliances", fileType: "json")
    }
    
    func display() {
        
    }
    
}
