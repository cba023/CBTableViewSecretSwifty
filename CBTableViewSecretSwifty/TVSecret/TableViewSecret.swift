//
//  TableViewSecret.swift
//  CBTableViewSecretSwifty
//
//  Created by flowerflower on 2019/1/19.
//  Copyright © 2019 Creater. All rights reserved.
//

import UIKit

class TableViewSecret: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var display:TableViewDisplay!
    var didSelectRowAtIndexPath: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Void)?
    
    init(tableView: UITableView, display: TableViewDisplay) {
        super.init()
        self.display = display
        tableView.delegate = self
        tableView.dataSource = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return display.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return display.sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return display.sections[section].headerHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return display.sections[section].headerEstimatedHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return display.sections[section].footerHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return display.sections[section].footerEstimatedHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return display.sections[indexPath.section].rows[indexPath.row].cellHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return display.sections[indexPath.section].rows[indexPath.row].cellEstimatedHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionDisplay = self.display.sections[section]
        if sectionDisplay.viewForHeader != nil {
            return sectionDisplay.viewForHeader!(tableView, section)
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionDisplay = self.display.sections[section]
        if sectionDisplay.viewForFooter != nil {
            return sectionDisplay.viewForFooter!(tableView, section)
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionDisplay = self.display.sections[indexPath.section]
        let rowDisplay = sectionDisplay.rows[indexPath.row]
        return rowDisplay.cellForRowAtIndexPath(tableView, indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionDisplay = self.display.sections[indexPath.section]
        let rowDisplay = sectionDisplay.rows[indexPath.row]
        if self.didSelectRowAtIndexPath != nil {
            self.didSelectRowAtIndexPath!(tableView, indexPath)
        }
        if rowDisplay.didSelectRowAtIndexPath != nil {
            rowDisplay.didSelectRowAtIndexPath!(tableView, indexPath)
        }
    }
}
