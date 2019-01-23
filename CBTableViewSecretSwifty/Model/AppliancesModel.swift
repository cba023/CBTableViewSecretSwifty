//
//  AppliancesModel.swift
//  CBTableViewSecretSwifty
//
//  Created by flowerflower on 2019/1/19.
//  Copyright © 2019 Creater. All rights reserved.
//

import UIKit
import HandyJSON

class AppliancesModel: HandyJSON {
    var color: String?
    var price: CGFloat = 0.0
    var name: String?
    
    required init() {}
}
