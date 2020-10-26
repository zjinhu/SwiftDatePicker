//
//  DatePickerVC.swift
//  SwiftDatePickerView
//
//  Created by iOS on 2020/10/22.
//

import UIKit
import SwiftShow
import SnapKit
public class DatePickerVC: UIViewController, PresentedViewType{
    public var presentedViewComponent: PresentedViewComponent?
    
    lazy var header: HeaderBar = {
        let v = HeaderBar(style: DatePicker.barStyle ?? .titleCenter,
                          title: DatePicker.titleString ?? "选择日期",
                          left: DatePicker.leftString ?? "取消",
                          right: DatePicker.rightString ?? "确定")
        
        v.backgroundColor = DatePicker.barColor ?? .white
        
        v.leftCallBack = { [weak self] in
            guard let `self` = self else{ return }
            self.dismiss(animated: true, completion: nil)
        }
        
        v.rightCallBack = { [weak self] in
            guard let `self` = self else{ return }
            self.pickerCallBack?(self.pickerDate)
            self.dismiss(animated: true, completion: nil)
        }
        
        return v
    }()
    
    fileprivate var pickView: DatePickerView?
    fileprivate var pickerDate: Date = Date.current()
    public typealias PickerClosure = (Date) -> Void
    fileprivate var pickerCallBack : PickerClosure?

    public convenience init(pickerType: DatePickerStyle) {
        self.init()
        pickView = DatePickerView(type: pickerType,
                                  minYear: DatePicker.minYear ?? Date.current().year,
                                  maxYear: DatePicker.maxYear ?? Date.current().year + 5,
                                  callBack: { [weak self] (date) in
            guard let `self` = self else{ return }
            self.pickerDate = date
        })
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = DatePicker.pickerBackColor ?? .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        view.addSubview(header)
        header.snp.makeConstraints { (m) in
            m.top.left.right.equalToSuperview()
            m.height.equalTo(DatePicker.barHeight ?? 45)
        }
         
        view.addSubview(pickView!)
        pickView?.snp.makeConstraints { (make) in
            make.top.equalTo(header.snp.bottom).offset(5)
            make.left.equalToSuperview()//.offset(5)
            make.right.equalToSuperview()//.offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }

    
    public static func showPicker(pickerType: DatePickerStyle = .pickerDate, callBack: @escaping PickerClosure){
        let vc = DatePickerVC(pickerType: pickerType)
        vc.pickerCallBack = callBack
        var component = PresentedViewComponent(contentSize: CGSize(width: DatePicker.pickerWidth ?? UIScreen.main.bounds.width, height: DatePicker.pickerHeight ?? 300))
        component.destination = .bottomBaseline
        component.presentTransitionType = .translation(origin: .bottomOutOfLine)
        vc.presentedViewComponent = component
        Show.currentViewController()?.presentViewController(vc)
    }
}

