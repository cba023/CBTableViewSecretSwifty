//
//  ViewController.swift
//  CBTableViewSecretSwifty
//
//  Created by flowerflower on 2019/1/19.
//  Copyright © 2019 Creater. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func goButonAction(_ sender: Any) {
        let vc = SecretVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

