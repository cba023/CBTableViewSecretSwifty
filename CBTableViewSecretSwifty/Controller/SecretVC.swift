//
//  SecretVC.swift
//  CBTableViewSecretSwifty
//
//  Created by flowerflower on 2019/1/19.
//  Copyright © 2019 Creater. All rights reserved.
//

import UIKit
import SwiftyJSON
import YYModel

class SecretVC: UIViewController {

    var tableView: UITableView!
    var secret: TableViewSecret!
    var newsModel: NewsModel?
    var personModel: PersonModel?
    var appliancesModel: AppliancesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Secret"
        self.configUI()
        self.configData()
        self.display()
    }
    
    func configUI() {
        self.tableView = UITableView(frame: self.view.bounds, style: .grouped)
        self.view.addSubview(tableView)
    }
    
    func configData() {
        let dicNews = Util.getJsonData(from: "NewsList", fileType: "json")
        let dicPerson = Util.getJsonData(from: "Person", fileType: "json")
        let dicAppliances = Util.getJsonData(from: "Appliances", fileType: "json")
        newsModel = NewsModel.yy_model(with: dicNews!)
        personModel = PersonModel.yy_model(with: dicPerson!)
        appliancesModel = AppliancesModel.yy_model(with: dicAppliances!)
    }
    
    func display() {
        let display = TableViewDisplay(sectionsCallback: { (sections) in
            // 1.News
            let sec0 = TableViewSectionDisplay(headerHeight: 45.0, autoHeaderHeight: false, footerHeight: 50.0, autoFooterHeight: false, rowsCallback: { (rows) in
                for (_, value) in (newsModel?.newslist!.enumerated())! {
                    let row = TableViewRowDisplay(cellHeight: 60.0, autoCellHeight: true, cellForRowAt: { (tableView, indexPath) -> UITableViewCell in
                        let cell = tableView.cell(nibClass: NewsListTableViewCell.self) as! NewsListTableViewCell
                        cell.lblTitle.text = value.title
                        cell.lblSubTitle.text = value.source
                        return cell
                    })
                    rows.append(row)
                }
            })
            sec0.viewForHeader = { tableView, section in
                let header = tableView?.headerFooter(nibClass: NewsListTableHeaderView.self) as! NewsListTableHeaderView
                header.lblName.text = "新闻列表"
                return header
            }
            sec0.viewForFooter = { tableView, section in
                let footer = tableView?.headerFooter(nibClass: NewsListTableFooterView.self) as! NewsListTableFooterView
                footer.lblDesc.text = "上面是新闻"
                return footer
            }
            // 2.Appliances
            let sec1 = TableViewSectionDisplay(headerHeight: 90.0, autoHeaderHeight: false, footerHeight: CGFloat.leastNormalMagnitude, autoFooterHeight: false, rowsCallback: { (rows) in
                let row = TableViewRowDisplay(cellHeight: 100.0, autoCellHeight: false, cellForRowAt: { (tableView, indexPath) -> UITableViewCell in
                    let cell = tableView.cell(nibClass: AppliancesTableViewCell.self) as! AppliancesTableViewCell
                    cell.lblName.text = self.appliancesModel?.name
                    cell.lblColor.text = self.appliancesModel?.color
                    cell.lblPrice.text = "\(self.appliancesModel!.price)"
                    return cell
                })
                rows.append(row)
            })
            sec1.viewForHeader = { tableView, section in
                let header = tableView?.headerFooter(nibClass: AppliancesTableHeaderView.self) as! AppliancesTableHeaderView
                header.lblName.text = "这里的电器"
                return header
            }

            // 3. Animal & Person
            let sec2 = TableViewSectionDisplay(headerHeight: 50.0, autoHeaderHeight: false, footerHeight: CGFloat.leastNormalMagnitude, autoFooterHeight: false, rowsCallback: { (rows) in
                let row0 = TableViewRowDisplay(cellHeight: self.tableView.bounds.size.width / 16.0 * 9.0, autoCellHeight: false, cellForRowAt: { (tableView, indexPath) -> UITableViewCell in
                    let cell = tableView.cell(nibClass: AnimalTCell.self) as! AnimalTCell
                    return cell
                })
                let row1 = TableViewRowDisplay(cellHeight: 80.0, autoCellHeight: false, cellForRowAt: { (tableView, indexPath) -> UITableViewCell in
                    let cell = tableView.cell(anyClass: PersonTCell.self) as! PersonTCell
                    cell.lblName.text = "张三"
                    return cell
                })
                
                rows.append(row0)
                rows.append(row1)
            })
            sections.append(sec0)
            sections.append(sec1)
            sections.append(sec2)
        })
        self.secret = TableViewSecret(tableView: tableView, display: display)
        self.secret.didSelectRowAtIndexPath = {(tableView, indexPath)
            in
            tableView .deselectRow(at: indexPath, animated: true)
        }
    }
}
