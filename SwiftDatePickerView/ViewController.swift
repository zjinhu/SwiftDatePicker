//
//  ViewController.swift
//  SwiftDatePickerView
//
//  Created by iOS on 2020/10/21.
//

import UIKit
import SwiftBrick
import Swift_Form

class ViewController: JHTableViewController {
    
    lazy var former = Former(tableView: self.tableView!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let pick = DatePickerView(type: .pickerDateHourMinute, minYear: 1999, maxYear: 2030) { (date) in
            print("\(date)")
        }

        view.addSubview(pick)
        pick.snp.makeConstraints { (m) in
            m.left.right.equalToSuperview()
            m.top.equalToSuperview().offset(50)
            m.height.equalTo(200)
        }
        
        tableView?.snp.remakeConstraints({ (m) in
            m.top.equalTo(pick.snp.bottom).offset(20)
            m.left.right.equalToSuperview()
            m.bottom.equalToSuperview()
        })
        
        let row1 = LabelRow()
        row1.title = "点击弹窗StartEndTimePickerVC"
        row1.cell.accessoryType = .disclosureIndicator
        row1.cell.addDownLine()
        row1.onSelected { [weak self](row) in
            guard let `self` = self else {return}
            self.action()
            
        }
        
        let row2 = LabelRow()
        row2.title = "点击弹窗UIDatePickerVC"
        row2.cell.accessoryType = .disclosureIndicator
        row2.cell.addDownLine()
        row2.onSelected { [weak self](row) in
            guard let `self` = self else {return}
            self.action2()
            
        }
        
        let row3 = LabelRow()
        row3.title = "点击弹窗DatePickerVC"
        row3.cell.accessoryType = .disclosureIndicator
        row3.cell.addDownLine()
        row3.onSelected { [weak self](row) in
            guard let `self` = self else {return}
            self.action3()
            
        }
        
        let row4 = LabelRow()
        row4.title = "点击弹窗DatePickerVC"
        row4.subTitle = "多种样式"
        row4.cell.accessoryType = .disclosureIndicator
        row4.cell.addDownLine()
        row4.onSelected { [weak self](row) in
            guard let `self` = self else {return}
            self.action1()
        }

        let section = SectionFormer(row1, row2, row3, row4)
        
        former.append(sectionFormer: section)

    }

    func action(){

        StartEndTimePickerVC.showPicker { (bar) in
            bar.titleString = "选择时间"
            bar.barColor = .orange
            bar.leftString = "左"
            bar.rightString = "右"
        } dateCallBack: { (start, end) in
            print("\(String(describing: start))--\(String(describing: end))")
        } dismissCallBack: {
            print("close")
        }

    }
    
    func action1(){

        DatePickerVC.showPicker(pickerType: .pickerMonthDayHour) { (bar) in
            bar.titleString = "选择日期"
            bar.barStyle = .titleLeft
            bar.barColor = .orange
            bar.leftNorImage = UIImage(named: "image_cancle")
            bar.rightNorImage = UIImage(named: "image_done")
            bar.leftWidth = 40
            bar.rightWidth = 40
        } dateCallBack: { (date) in
            print("\(String(describing: date))")
        } dismissCallBack: {
            print("close")
        }

    }
    
    func action2(){
        
//        DatePicker.pickerBackColor = .systemPink
        
        UIDatePickerVC.showPicker(mode: .dateAndTime) { (bar) in
            bar.titleString = "选择日期"
            bar.barColor = .orange
            bar.leftNorImage = UIImage(named: "image_cancle")
            bar.rightNorImage = UIImage(named: "image_done")
        } dateCallBack: { (date) in
            print("\(String(describing: date))")
        } dismissCallBack: {
            print("close")
        }

    }
    
    func action3(){

        DatePickerVC.showPicker(pickerType: .pickerDateHourMinute) { (bar) in
            bar.titleString = "选择日期"
            bar.barColor = .orange
            bar.leftNorImage = UIImage(named: "image_cancle")
            bar.rightNorImage = UIImage(named: "image_done")
        } dateCallBack: { (date) in
            print("\(String(describing: date))")
        } dismissCallBack: {
            print("close")
        }

    }
}

