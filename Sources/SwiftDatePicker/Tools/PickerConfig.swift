//
//  PickerTools.swift
//  SwiftDatePickerView
//
//  Created by iOS on 2020/10/26.
//

import UIKit

public typealias CloseClosure = () -> Void
public typealias PickerClosure = (Date) -> Void
public typealias TimeIntervalClosure = (Date, Date) -> Void

public struct DatePicker {
    public static var pickerFont: UIFont?
    public static var pickerTextColor: UIColor?
    public static var pickerBackColor: UIColor?
    
    public static var pickerWidth: CGFloat?
    public static var pickerHeight: CGFloat?
    
    public static var minYear: Int?
    public static var maxYear: Int?
}

public struct HeadBar {
    public static var barStyle: BarStyle?

    public static var barColor: UIColor?
    public static var barHeight: CGFloat?
    
    public static var titleFont: UIFont?
    public static var buttonFont: UIFont?
    
    public static var titleString: String?
    public static var leftString: String?
    public static var rightString: String?

    public static var barTitleColor: UIColor?
    public static var barButtonColor: UIColor?
    
}

extension Date {
    public static func current() -> Date{
        let calendar = Calendar.current
        var comp = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        comp.timeZone = TimeZone(secondsFromGMT: 0)
        let currentDate = calendar.date(from: comp)
        return currentDate ?? Date()
    }
}
