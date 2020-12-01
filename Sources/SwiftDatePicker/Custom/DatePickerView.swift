//
//  DatePickerView.swift
//  SwiftDatePickerView
//
//  Created by iOS on 2020/10/21.
//

import UIKit
import SwiftDate
import SnapKit
public enum DatePickerStyle {
    case pickerDate //年月日
    case pickerDateHour //年月日时
    case pickerDateHourMinute //年月日时分
    case pickerMonthDay //月日
    case pickerMonthDayHour //月日时
    case pickerMonthDayHourMinute //月日时分
    case pickerTime //时分
}

public class DatePickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource{

    fileprivate var year: Int = Date.current().year
    fileprivate var month: Int = Date.current().month
    fileprivate var day: Int = Date.current().day
    fileprivate var hour: Int = Date.current().hour
    fileprivate var minute: Int = Date.current().minute

    fileprivate var pickerType: DatePickerStyle = .pickerDate
    
    fileprivate var min: Int = 0
    fileprivate var max: Int = 0
    
    public typealias PickerClosure = (Date) -> Void
    fileprivate var pickerCallBack : PickerClosure?
    
    public convenience init(type: DatePickerStyle,
                     minYear: Int = Date.current().year,
                     maxYear: Int = Date.current().year + 5,
                     callBack: @escaping PickerClosure){
        self.init()
        pickerType = type
        min = minYear
        max = maxYear
        pickerCallBack = callBack
        
        let pickerView = UIPickerView()
        addSubview(pickerView)
        pickerView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let yearInx = getYearList().firstIndex { (e) -> Bool in
            return e == year
        } ?? 0
        
        let monthInx = DateList.getMonthList().firstIndex { (e) -> Bool in
            return e == month
        } ?? 0
        
        let dayInx = getDayList().firstIndex { (e) -> Bool in
            return e == day
        } ?? 0
        
        let hourInx = DateList.getHourList().firstIndex { (e) -> Bool in
            return e == hour
        } ?? 0
        
        let minuteInx = DateList.getMinuteList().firstIndex { (e) -> Bool in
            return e == minute
        } ?? 0
        
        switch pickerType {
        case .pickerDate: //年月日
            pickerView.selectRow(yearInx, inComponent: 0, animated: false)
            pickerView.selectRow(monthInx, inComponent: 1, animated: false)
            pickerView.selectRow(dayInx, inComponent: 2, animated: false)
        case .pickerDateHour: //年月日时
            pickerView.selectRow(yearInx, inComponent: 0, animated: false)
            pickerView.selectRow(monthInx, inComponent: 1, animated: false)
            pickerView.selectRow(dayInx, inComponent: 2, animated: false)
            pickerView.selectRow(hourInx, inComponent: 3, animated: false)
        case .pickerDateHourMinute: //年月日时分
            pickerView.selectRow(yearInx, inComponent: 0, animated: false)
            pickerView.selectRow(monthInx, inComponent: 1, animated: false)
            pickerView.selectRow(dayInx, inComponent: 2, animated: false)
            pickerView.selectRow(hourInx, inComponent: 3, animated: false)
            pickerView.selectRow(minuteInx, inComponent: 4, animated: false)
        case .pickerMonthDay: //月日
            pickerView.selectRow(monthInx, inComponent: 0, animated: false)
            pickerView.selectRow(dayInx, inComponent: 1, animated: false)
        case .pickerMonthDayHour: //月日时
            pickerView.selectRow(monthInx, inComponent: 0, animated: false)
            pickerView.selectRow(dayInx, inComponent: 1, animated: false)
            pickerView.selectRow(hourInx, inComponent: 2, animated: false)
        case .pickerMonthDayHourMinute: //月日时分
            pickerView.selectRow(monthInx, inComponent: 0, animated: false)
            pickerView.selectRow(dayInx, inComponent: 1, animated: false)
            pickerView.selectRow(hourInx, inComponent: 2, animated: false)
            pickerView.selectRow(minuteInx, inComponent: 3, animated: false)
        case .pickerTime: //时分
            pickerView.selectRow(hourInx, inComponent: 0, animated: false)
            pickerView.selectRow(minuteInx, inComponent: 1, animated: false)
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerType {
        case .pickerMonthDay, .pickerTime:
            return 2
        case .pickerDate, .pickerMonthDayHour:
            return 3
        case .pickerDateHour, .pickerMonthDayHourMinute:
            return 4
        case .pickerDateHourMinute:
            return 5
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        // 每列多宽
        switch pickerType {
        case .pickerMonthDay, .pickerTime:
            return (bounds.width-(10*2+5*1))/2
        case .pickerDate, .pickerMonthDayHour:
            return (bounds.width-(10*2+5*2))/3
        case .pickerDateHour, .pickerMonthDayHourMinute:
            return (bounds.width-(10*2+5*3))/4
        case .pickerDateHourMinute:
            return (bounds.width-(10*2+5*4))/5
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerType {
        case .pickerDate: //年月日
            if component == 1 {
                return DateList.getMonthList().count
            }
            if component == 2 {
                return getDayList().count
            }
            return getYearList().count
        case .pickerDateHour: //年月日时
            if component == 1 {
                return DateList.getMonthList().count
            }
            if component == 2 {
                return getDayList().count
            }
            if component == 3 {
                return DateList.getHourList().count
            }
            return getYearList().count
        case .pickerDateHourMinute: //年月日时分
            if component == 1 {
                return DateList.getMonthList().count
            }
            if component == 2 {
                return getDayList().count
            }
            if component == 3 {
                return DateList.getHourList().count
            }
            if component == 4 {
                return DateList.getMinuteList().count
            }
            return getYearList().count
        
        case .pickerMonthDay: //月日
            if component == 1 {
                return getDayList().count
            }
            return DateList.getMonthList().count
            
        case .pickerMonthDayHour: //月日时
            if component == 1 {
                return getDayList().count
            }
            if component == 2 {
                return DateList.getHourList().count
            }
            return DateList.getMonthList().count
        case .pickerMonthDayHourMinute: //月日时分
            if component == 1 {
                return getDayList().count
            }
            if component == 2 {
                return DateList.getHourList().count
            }
            if component == 3 {
                return DateList.getMinuteList().count
            }
            return DateList.getMonthList().count
        
        case .pickerTime: //时分
            if component == 1 {
                return DateList.getMinuteList().count
            }
            return DateList.getHourList().count

        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        //每行多高
        return 40
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view {
            label = v as! UILabel
        }
        label.font = DatePicker.pickerFont ?? UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .black
        switch pickerType {
        case .pickerDate: //年月日
            if component == 0 {
                label.text = "\(getYearList()[row]) 年"
            }
            if component == 1 {
                label.text = String(format: "%02d 月", DateList.getMonthList()[row])
            }
            if component == 2 {
                label.text = String(format: "%02d 日", getDayList()[row])
            }
            
        case .pickerDateHour: //年月日时
            if component == 0 {
                label.text = "\(getYearList()[row]) 年"
            }
            if component == 1 {
                label.text = String(format: "%02d 月", DateList.getMonthList()[row])
            }
            if component == 2 {
                label.text = String(format: "%02d 日", getDayList()[row])
            }
            if component == 3 {
                label.text = String(format: "%02d 时", DateList.getHourList()[row])
            }
        case .pickerDateHourMinute: //年月日时分
            if component == 0 {
                label.text = "\(getYearList()[row]) 年"
            }
            if component == 1 {
                label.text = String(format: "%02d 月", DateList.getMonthList()[row])
            }
            if component == 2 {
                label.text = String(format: "%02d 日", getDayList()[row])
            }
            if component == 3 {
                label.text = String(format: "%02d 时", DateList.getHourList()[row])
            }
            if component == 4 {
                label.text = String(format: "%02d 分", DateList.getMinuteList()[row])
            }
        
        case .pickerMonthDay: //月日
            if component == 0 {
                label.text = String(format: "%02d 月", DateList.getMonthList()[row])
            }
            if component == 1 {
                label.text = String(format: "%02d 日", getDayList()[row])
            }
        case .pickerMonthDayHour: //月日时
            if component == 0 {
                label.text = String(format: "%02d 月", DateList.getMonthList()[row])
            }
            if component == 1 {
                label.text = String(format: "%02d 日", getDayList()[row])
            }
            if component == 2 {
                label.text = String(format: "%02d 时", DateList.getHourList()[row])
            }
        case .pickerMonthDayHourMinute: //月日时分
            if component == 0 {
                label.text = String(format: "%02d 月", DateList.getMonthList()[row])
            }
            if component == 1 {
                label.text = String(format: "%02d 日", getDayList()[row])
            }
            if component == 2 {
                label.text = String(format: "%02d 时", DateList.getHourList()[row])
            }
            if component == 3 {
                label.text = String(format: "%02d 分", DateList.getMinuteList()[row])
            }
        
        case .pickerTime: //时分
            if component == 0 {
                label.text = String(format: "%02d 时", DateList.getHourList()[row])
            }
            if component == 1 {
                label.text = String(format: "%02d 分", DateList.getMinuteList()[row])
            }
    
        }
        return label
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerType {
        case .pickerDate: //年月日
            if component == 0 {
                year = getYearList()[row]
                pickerView.reloadComponent(2)
            }
            if component == 1 {
                month = DateList.getMonthList()[row]
                pickerView.reloadComponent(2)
            }
            if component == 2 {
                day = getDayList()[row]
            }
            
        case .pickerDateHour: //年月日时
            if component == 0 {
                year = getYearList()[row]
                pickerView.reloadComponent(2)
            }
            if component == 1 {
                month = DateList.getMonthList()[row]
                pickerView.reloadComponent(2)
            }
            if component == 2 {
                day = getDayList()[row]
            }
            if component == 3 {
                hour = DateList.getHourList()[row]
            }
        case .pickerDateHourMinute: //年月日时分
            if component == 0 {
                year = getYearList()[row]
                pickerView.reloadComponent(2)
            }
            if component == 1 {
                month = DateList.getMonthList()[row]
                pickerView.reloadComponent(2)
            }
            if component == 2 {
                day = getDayList()[row]
            }
            if component == 3 {
                hour = DateList.getHourList()[row]
            }
            if component == 4 {
                minute = DateList.getMinuteList()[row]
            }
       
        case .pickerMonthDay: //月日
            if component == 0 {
                month = DateList.getMonthList()[row]
                pickerView.reloadComponent(1)
            }
            if component == 1 {
                day = getDayList()[row]
            }
        case .pickerMonthDayHour: //月日时
            if component == 0 {
                month = DateList.getMonthList()[row]
                pickerView.reloadComponent(1)
            }
            if component == 1 {
                day = getDayList()[row]
            }
            if component == 2 {
                hour = DateList.getHourList()[row]
            }
        case .pickerMonthDayHourMinute: //月日时分
            if component == 0 {
                month = DateList.getMonthList()[row]
                pickerView.reloadComponent(1)
            }
            if component == 1 {
                day = getDayList()[row]
            }
            if component == 2 {
                hour = DateList.getHourList()[row]
            }
            if component == 3 {
                minute = DateList.getMinuteList()[row]
            }
        
        case .pickerTime: //时分
            if component == 0 {
                hour = DateList.getHourList()[row]
            }
            if component == 1 {
                minute = DateList.getMinuteList()[row]
            }
        }
        
        let date = Date(year: year, month: month, day: day, hour: hour, minute: minute)
        pickerCallBack?(date)

    }
    
    func getDayList() -> [Int] {
        return DateList.getDayList(year: year, month: month)
    }
    
    func getYearList() -> [Int] {
        var years = [Int]()
        for i in min...max {
            years.append(i)
        }
        return years
    }
}


struct DateList {

    static func getMonthList() -> [Int]{
        return [01,02,03,04,05,06,07,08,09,10,
                11,12]
    }
    
    static func getDayList(year: Int, month: Int) -> [Int]{
        let array = [01,02,03,04,05,06,07,08,09,10,
                     11,12,13,14,15,16,17,18,19,20,
                     21,22,23,24,25,26,27,28,29,30,31]
        let range = getDaysInMonth(year: year, month: month)
        let rangeArray = array[0..<range]
        return Array(rangeArray)
    }
    
    static func getHourList() -> [Int]{
        return [00,01,02,03,04,05,06,07,08,09,
                10,11,12,13,14,15,16,17,18,19,
                20,21,22,23]
    }
    
    static func getMinuteList() -> [Int]{
        return [00,01,02,03,04,05,06,07,08,09,
                10,11,12,13,14,15,16,17,18,19,
                20,21,22,23,24,25,26,27,28,29,
                30,31,32,33,34,35,36,37,38,39,
                40,41,42,43,44,45,46,47,48,49,
                50,51,52,53,54,55,56,57,58,59]
    }

    static func getDaysInMonth( year: Int, month: Int) -> Int{
        let calendar = Calendar.current
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
         
        var endComps = DateComponents()
        endComps.day = 1
        endComps.month = month == 12 ? 1 : month + 1
        endComps.year = month == 12 ? year + 1 : year
         
        let startDate = calendar.date(from: startComps)!
        let endDate = calendar.date(from:endComps)!
         
        let diff = calendar.dateComponents([.day], from: startDate, to: endDate)
        return diff.day!
    }
}
