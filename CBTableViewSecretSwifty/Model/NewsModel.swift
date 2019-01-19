//
//  NewsModel.swift
//  CBTableViewSecretSwifty
//
//  Created by flowerflower on 2019/1/19.
//  Copyright © 2019 Creater. All rights reserved.
//

import UIKit
import YYModel

@objcMembers

class Ext_action :NSObject, YYModel {
    var fimgurl30: String?
    var fimgurl33: String?
    var fimgurl32: String?
    
}

@objcMembers

class Ext_data :NSObject, YYModel {
    var src: String?
    var desc: String?
    var ext_action: Ext_action?
    
}

@objcMembers

class Newslist :NSObject, YYModel {
    var ext_data: Ext_data?
    var source: String?
    var time: String?
    var title: String?
    var url: String?
    var videoTotalTime: String?
    var thumbnails_qqnews: [String]?
    var abstract: String?
    var imagecount: Int = 0
    var origUrl: String?
    var graphicLiveID: String?
    var uinnick: String?
    var flag: String?
    var tag: [String]?
    var voteId: String?
    var articletype: String?
    var voteNum: String?
    var qishu: String?
    var id: String?
    var timestamp: Int = 0
    var commentid: String?
    var comments: Int = 0
    var weiboid: String?
    var comment: String?
    var uinname: String?
    var surl: String?
    var thumbnails: [String]?
    
}

@objcMembers

class NewsModel :NSObject, YYModel {
    var ret: Int = 0
    var newslist: [Newslist]?
    static func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["newslist": Newslist.self]
    }
    
}

