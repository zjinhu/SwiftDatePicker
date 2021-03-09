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

        let pick = DatePickerView(type: .pickerDateHourMinute,
                                  minYear: 1999,
                                  maxYear: 2030) { (date) in
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
        row1.onSelected { (row) in
            
            StartEndTimePickerVC.showPicker{ (bar) in
                bar.titleString = "选择时间"
                bar.barColor = .white
                bar.leftString = "取消"
                bar.rightString = "确认"
            } dateCallBack: { (start, end) in
                print("\(String(describing: start))--\(String(describing: end))")
            } dismissCallBack: {
                print("close")
            }
            
        }
        
        let row2 = LabelRow()
        row2.title = "点击弹窗StartEndTimePickerVC"
        row2.subTitle = "有默认值"
        row2.cell.accessoryType = .disclosureIndicator
        row2.cell.addDownLine()
        row2.onSelected { (row) in
            
            StartEndTimePickerVC.showPicker(startDate: Date(hour: 13, minute: 22)!,
                                            endDate: Date(hour: 17, minute: 22)!) { (bar) in
                bar.titleString = "选择时间"
                bar.barTitleColor = .white
                bar.barColor = .black
                bar.leftString = "关闭"
                bar.rightString = "好的"
                bar.leftNorColor = .white
                bar.rightNorColor = .orange
            } dateCallBack: { (start, end) in
                print("\(String(describing: start))--\(String(describing: end))")
            } dismissCallBack: {
                print("close")
            }
            
        }
        
        let row3 = LabelRow()
        row3.title = "点击弹窗UIDatePickerVC"

        row3.cell.accessoryType = .disclosureIndicator
        row3.cell.addDownLine()
        row3.onSelected { (row) in

            UIDatePickerVC.showPicker(mode: .dateAndTime) { (bar) in
                bar.titleString = "选择日期"
                bar.barColor = .random
                bar.leftNorImage = UIImage(named: "image_cancle")
                bar.rightNorImage = UIImage(named: "image_done")
            } dateCallBack: { (date) in
                print("\(String(describing: date))")
            } dismissCallBack: {
                print("close")
            }
            
        }
        
        let row4 = LabelRow()
        row4.title = "点击弹窗UIDatePickerVC"
        row4.subTitle = "有默认值"
        row4.cell.accessoryType = .disclosureIndicator
        row4.cell.addDownLine()
        row4.onSelected { (row) in

            UIDatePickerVC.showPicker(mode: .date,
                                      selectDate: Date(year: 2022, month: 10, day: 22, hour: 13, minute: 22, second: 33)!) { (bar) in
                bar.titleString = "选择日期"
                bar.barColor = .random
                bar.leftNorImage = UIImage(named: "image_cancle")
                bar.rightNorImage = UIImage(named: "image_done")
            } dateCallBack: { (date) in
                print("\(String(describing: date))")
            } dismissCallBack: {
                print("close")
            }
            
        }
        
        let row5 = LabelRow()
        row5.title = "点击弹窗DatePickerVC"
        row5.cell.accessoryType = .disclosureIndicator
        row5.cell.addDownLine()
        row5.onSelected {(row) in
            DatePickerVC.showPicker(pickerType: .pickerDateHourMinute) { (bar) in
                bar.titleString = "选择日期"
                bar.barColor = .random
                bar.leftNorImage = UIImage(named: "image_cancle")
                bar.rightNorImage = UIImage(named: "image_done")
            } dateCallBack: { (date) in
                print("\(String(describing: date))")
            } dismissCallBack: {
                print("close")
            }
        }
        
        let row6 = LabelRow()
        row6.title = "点击弹窗DatePickerVC"
        row6.subTitle = "标题样式,有默认值"
        row6.cell.accessoryType = .disclosureIndicator
        row6.cell.addDownLine()
        row6.onSelected { (row) in
            DatePickerVC.showPicker(pickerType: .pickerMonthDayHour,
                                    selectDate: Date(year: 2022, month: 10, day: 22, hour: 13, minute: 22, second: 33)!) { (bar) in
                bar.titleString = "选择日期"
                bar.barStyle = .titleLeft
                bar.barColor = .random
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

        let section = SectionFormer(row1, row2, row3, row4, row5, row6)
        
        former.append(sectionFormer: section)

    }

}

 extension Date {
    
    init?(
        calendar: Calendar? = Calendar.current,
        timeZone: TimeZone? = NSTimeZone.default,
        year: Int? = Date().getYear(),
        month: Int? = Date().getMonth(),
        day: Int? = Date().getDay(),
        hour: Int? = Date().getHour(),
        minute: Int? = Date().getMinute(),
        second: Int? = Date().getSecond()) {
        
        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = timeZone
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        
        guard let date = calendar?.date(from: components) else { return nil }
        self = date
    }
 }
