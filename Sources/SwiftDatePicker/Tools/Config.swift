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
public typealias HeadBarConfig = (_ config: HeadBar) -> Void

public struct DatePicker {
    public static var pickerFont: UIFont?
    public static var pickerTextColor: UIColor?
    public static var pickerBackColor: UIColor?
    
    public static var pickerWidth: CGFloat?
    public static var pickerHeight: CGFloat?
    
    public static var minYear: Int?
    public static var maxYear: Int?
}

public class HeadBar {
    public var barStyle: BarStyle = .titleCenter

    public var barColor: UIColor?
    public var barHeight: CGFloat?
    
    public var titleFont: UIFont?
    public var buttonFont: UIFont?
    
    public var titleString: String?
    public var leftString: String?
    public var rightString: String?
    
    public var leftNorImage: UIImage?
    public var rightNorImage: UIImage?
    public var leftHigImage: UIImage?
    public var rightHigImage: UIImage?
    
    public var barTitleColor: UIColor?
    public var barButtonColor: UIColor?
    
    public var leftWidth: CGFloat?
    public var rightWidth: CGFloat?
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
