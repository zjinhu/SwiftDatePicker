//
//  DateTool.swift
//  SwiftDatePickerView
//
//  Created by iOS on 2021/3/9.
//

import Foundation

public extension Date {

    var calendar: Calendar {
        return Calendar.current
    }
    
    func getYear() -> Int{
        let components = calendar.dateComponents([.year], from: self)
        let num = components.year ?? 0
        return num
    }
    
    func getMonth() -> Int{
        let components = calendar.dateComponents([.month], from: self)
        let num = components.month ?? 0
        return num
    }
    
    func getDay() -> Int{
        let components = calendar.dateComponents([.day], from: self)
        let num = components.day ?? 0
        return num
    }

    func getWeek() -> Int{
        ///拿到现在的week数字
        let components = calendar.dateComponents([.weekday], from: self)
        let weekCount = components.weekday ?? 0
        return weekCount
    }
    
    func getHour() -> Int{
        let components = calendar.dateComponents([.hour], from: self)
        let num = components.hour ?? 0
        return num
    }
    
    func getMinute() -> Int{
        let components = calendar.dateComponents([.minute], from: self)
        let num = components.minute ?? 0
        return num
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

