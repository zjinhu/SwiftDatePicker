//
//  DatePickerView.swift
//  SwiftDatePickerView
//
//  Created by iOS on 2020/10/21.
//

import UIKit
import SnapKit

public enum DatePickerStyle {
    ///年月日
    case pickerDate
    ///年月日时
    case pickerDateHour
    ///年月日时分
    case pickerDateHourMinute
    ///月日
    case pickerMonthDay
    ///月日时
    case pickerMonthDayHour
    ///月日时分
    case pickerMonthDayHourMinute
    ///时分
    case pickerTime
}

public class DatePickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource{

    
    var selDate: Date?{
        didSet{
            guard let date = selDate else {
                return
            }
            year = date.getYear()
            month = date.getMonth()
            day = date.getDay()
            hour = date.getHour()
            minute = date.getMinute()
        }
    }
    
    fileprivate var year: Int = 0
    fileprivate var month: Int = 0
    fileprivate var day: Int = 0
    fileprivate var hour: Int = 0
    fileprivate var minute: Int = 0
    
    fileprivate var pickerType: DatePickerStyle = .pickerDate
    
    fileprivate var min: Int = 0
    fileprivate var max: Int = 0
    fileprivate var isShowUnit: Bool = true
    
    public typealias PickerClosure = (Date) -> Void
    fileprivate var pickerCallBack : PickerClosure?
    
    /// 初始化DatePickerView
    /// - Parameters:
    ///   - type: DatePickerStyle样式
    ///   - selectDate: 已选定时间
    ///   - minYear:  滚轮最小年份(不需要选择年费可不加)
    ///   - maxYear: 滚轮最大年份(不需要选择年费可不加)
    ///   - showUnit: 是否显示单位(年月日等)
    ///   - callBack: 回调Date
    public convenience init(type: DatePickerStyle,
                            selectDate: Date = Date(),
                            minYear: Int = Date().getYear(),
                            maxYear: Int = Date().getYear() + 5,
                            showUnit: Bool = true,
                            callBack: @escaping PickerClosure){
        self.init()
        pickerType = type
        year = selectDate.getYear()
        month = selectDate.getMonth()
        day = selectDate.getDay()
        hour = selectDate.getHour()
        minute = selectDate.getMinute()
        min = minYear
        max = maxYear
        isShowUnit = showUnit
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
        label.textColor = DatePicker.pickerTextColor ?? .black
        switch pickerType {
        case .pickerDate: //年月日
            if component == 0 {
                label.text = String(format: "%d %@", getYearList()[row], isShowUnit ? "年" : "")
            }
            if component == 1 {
                label.text = String(format: "%02d %@", DateList.getMonthList()[row], isShowUnit ? "月" : "")
            }
            if component == 2 {
                label.text = String(format: "%02d %@", getDayList()[row], isShowUnit ? "日" : "")
            }
            
        case .pickerDateHour: //年月日时
            if component == 0 {
                label.text = String(format: "%d %@", getYearList()[row], isShowUnit ? "年" : "")
            }
            if component == 1 {
                label.text = String(format: "%02d %@", DateList.getMonthList()[row], isShowUnit ? "月" : "")
            }
            if component == 2 {
                label.text = String(format: "%02d %@", getDayList()[row], isShowUnit ? "日" : "")
            }
            if component == 3 {
                label.text = String(format: "%02d %@", DateList.getHourList()[row], isShowUnit ? "时" : "")
            }
        case .pickerDateHourMinute: //年月日时分
            if component == 0 {
                label.text = String(format: "%d %@", getYearList()[row], isShowUnit ? "年" : "")
            }
            if component == 1 {
                label.text = String(format: "%02d %@", DateList.getMonthList()[row], isShowUnit ? "月" : "")
            }
            if component == 2 {
                label.text = String(format: "%02d %@", getDayList()[row], isShowUnit ? "日" : "")
            }
            if component == 3 {
                label.text = String(format: "%02d %@", DateList.getHourList()[row], isShowUnit ? "时" : "")
            }
            if component == 4 {
                label.text = String(format: "%02d %@", DateList.getMinuteList()[row], isShowUnit ? "分" : "")
            }
            
        case .pickerMonthDay: //月日
            if component == 0 {
                label.text = String(format: "%02d %@", DateList.getMonthList()[row], isShowUnit ? "月" : "")
            }
            if component == 1 {
                label.text = String(format: "%02d %@", getDayList()[row], isShowUnit ? "日" : "")
            }
        case .pickerMonthDayHour: //月日时
            if component == 0 {
                label.text = String(format: "%02d %@", DateList.getMonthList()[row], isShowUnit ? "月" : "")
            }
            if component == 1 {
                label.text = String(format: "%02d %@", getDayList()[row], isShowUnit ? "日" : "")
            }
            if component == 2 {
                label.text = String(format: "%02d %@", DateList.getHourList()[row], isShowUnit ? "时" : "")
            }
        case .pickerMonthDayHourMinute: //月日时分
            if component == 0 {
                label.text = String(format: "%02d %@", DateList.getMonthList()[row], isShowUnit ? "月" : "")
            }
            if component == 1 {
                label.text = String(format: "%02d %@", getDayList()[row], isShowUnit ? "日" : "")
            }
            if component == 2 {
                label.text = String(format: "%02d %@", DateList.getHourList()[row], isShowUnit ? "时" : "")
            }
            if component == 3 {
                label.text = String(format: "%02d %@", DateList.getMinuteList()[row], isShowUnit ? "分" : "")
            }
            
        case .pickerTime: //时分
            if component == 0 {
                label.text = String(format: "%02d %@", DateList.getHourList()[row], isShowUnit ? "时" : "")
            }
            if component == 1 {
                label.text = String(format: "%02d %@", DateList.getMinuteList()[row], isShowUnit ? "分" : "")
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
        
        let calendar = Calendar.current
        var components = DateComponents() 
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        let date =  calendar.date(from: components)!
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


