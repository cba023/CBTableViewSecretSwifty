//
//  Util.swift
//  CBTableViewSecretSwifty
//
//  Created by flowerflower on 2019/1/19.
//  Copyright © 2019 Creater. All rights reserved.
//

import UIKit

class Util {
    static func loadXib(name: String) -> Any? {
        let view = Bundle.main.loadNibNamed(name, owner: self, options: nil)
        return view
    }
    
    static func getJsonData(from jsonPath: String, fileType: String) -> Dictionary<String, AnyObject>? {
        let path = Bundle.main.path(forResource: jsonPath, ofType: fileType)
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            let jsonDic = jsonData as! Dictionary<String, AnyObject>
            return jsonDic;
        } catch let error as Error? {
            print("Local json reading error:",error!)
        }
        return nil
    }
}
