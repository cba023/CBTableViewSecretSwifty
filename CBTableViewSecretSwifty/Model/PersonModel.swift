//
//  PersonModel.swift
//  CBTableViewSecretSwifty
//
//  Created by flowerflower on 2019/1/19.
//  Copyright © 2019 Creater. All rights reserved.
//

import UIKit
import HandyJSON

class PersonModel: HandyJSON {
    var gender: String?
    var age: Int = 0
    var country: String?
    var height: Int = 0
    var name: String?
    
    required init() {}
}
