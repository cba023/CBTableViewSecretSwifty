//
//  TableViewDisplay.swift
//  CBTableViewSecretSwifty
//
//  Created by flowerflower on 2019/1/19.
//  Copyright © 2019 Creater. All rights reserved.
//

import UIKit

class TableViewRowDisplay {
    
    let cellHeight:CGFloat!
    let autoCellHeight:Bool!
    let cellForRowAtIndexPath: ((_ tableView: UITableView, _ indexPath:IndexPath) -> UITableViewCell)!
    var didSelectRowAtIndexPath: ((_ tableView: UITableView, _ indexPath:IndexPath) -> Void)?
    
    init(cellHeight:CGFloat, autoCellHeight:Bool, cellForRowAt indexPath:@escaping (_ tableView: UITableView, _ indexPath:IndexPath) -> UITableViewCell) {
        self.autoCellHeight = autoCellHeight
        self.cellHeight = self.autoCellHeight == true ? UITableView.automaticDimension: cellHeight;
        self.cellForRowAtIndexPath = indexPath
    }
}

class TableViewSectionDisplay {
    
    var rows: [TableViewRowDisplay] = []
    let headerHeight: CGFloat!
    let footerHeight: CGFloat!
    let autoHeaderHeight: Bool!
    let autoFooterHeight: Bool!
    public var viewForHeader: ((_ tableView: UITableView?, _ section: Int) -> UIView)?
    public var viewForFooter: ((_ tableView: UITableView?, _ section: Int) -> UIView)?
//    
//    init(headerHeight: CGFloat, autoHeaderHeight: Bool, footerHeight: CGFloat, autoFooterHeight: Bool, rowsCallback: (_ rows: inout Array<TableViewRowDisplay>) -> Void) {
//        self.autoHeaderHeight = autoHeaderHeight
//        self.autoFooterHeight = autoFooterHeight
//        self.headerHeight = self.autoHeaderHeight ? UITableView.automaticDimension : headerHeight
//        self.footerHeight = self.autoFooterHeight ? UITableView.automaticDimension : footerHeight
//        rowsCallback(&rows)
//    }
    
    init(headerHeight: CGFloat, footerHeight: CGFloat, autoHeaderHeight: Bool, autoFooterHeight: Bool, viewForHeader:((_ tableView: UITableView?, _ section: Int) -> UIView)?, viewForFooter:((_ tableView: UITableView?, _ section: Int) -> UIView)?, rowsCallback: (_ rows: inout Array<TableViewRowDisplay>) -> Void) {
        self.autoHeaderHeight = autoHeaderHeight
        self.autoFooterHeight = autoFooterHeight
        self.headerHeight = self.autoHeaderHeight ? UITableView.automaticDimension : headerHeight
        self.footerHeight = self.autoFooterHeight ? UITableView.automaticDimension : footerHeight
        self.viewForHeader = viewForHeader
        self.viewForFooter = viewForFooter
        rowsCallback(&rows)
    }
}

class TableViewDisplay {
    
    var sections: Array<TableViewSectionDisplay> = []
    
    init(sectionsCallback: (_ sections: inout Array<TableViewSectionDisplay>) -> Void) {
        sectionsCallback(&sections)
    }
}
