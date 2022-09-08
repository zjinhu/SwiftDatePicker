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

///DatePicker适配器
public struct DatePicker {
    ///滚轮内字体
    public static var pickerFont: UIFont?
    ///滚轮内字体颜色
    public static var pickerTextColor: UIColor?
    ///滚轮整体背景色
    public static var pickerBackColor: UIColor?
 
    ///滚轮弹窗高度
    public static var pickerHeight: CGFloat?
    ///滚轮最小年
    public static var minYear: Int?
    ///滚轮最大年
    public static var maxYear: Int?
}
///Header适配器
public class HeadBar {
    ///bar样式 标题居中/标题居左
    public var barStyle: BarStyle = .titleCenter
    ///bar背景色
    public var barColor: UIColor?
    ///bar高度
    public var barHeight: CGFloat?
    ///bar标题字体
    public var titleFont: UIFont?
    ///bar按钮字体
    public var buttonFont: UIFont?
    ///bar标题
    public var titleString: String?
    ///bar左按钮标题
    public var leftString: String?
    ///bar右按钮标题
    public var rightString: String?
    ///bar左按钮图片
    public var leftNorImage: UIImage?
    ///bar右按钮图片
    public var rightNorImage: UIImage?
    ///bar左按钮按下图片
    public var leftHigImage: UIImage?
    ///bar右按钮按下图片
    public var rightHigImage: UIImage?
    ///bar标题字体颜色
    public var barTitleColor: UIColor?
    ///bar左按钮字体颜色
    public var leftNorColor: UIColor?
    ///bar右按钮字体颜色
    public var rightNorColor: UIColor?
    ///bar左按钮按下字体颜色
    public var leftHigColor: UIColor?
    ///bar右按钮按下字体颜色
    public var rightHigColor: UIColor?
    ///bar左按钮宽度
    public var leftWidth: CGFloat?
    ///bar右按钮宽度
    public var rightWidth: CGFloat?
}

