//
//  UIDatePickerVC.swift
//  SwiftDatePickerView
//
//  Created by iOS on 2020/10/26.
//

import UIKit
import SwiftShow
import SnapKit
public class UIDatePickerVC: UIViewController, PresentedViewType {
    public var presentedViewComponent: PresentedViewComponent?

    fileprivate var dismissCallBack : CloseClosure?
    fileprivate var pickerCallBack : PickerClosure?
    fileprivate var pickerDate: Date = Date.current()
    
    lazy var header: HeaderBar = {
        let v = HeaderBar(style: HeadBar.barStyle ?? .titleCenter,
                          title: HeadBar.titleString ?? "选择日期",
                          left: HeadBar.leftString ?? "取消",
                          right: HeadBar.rightString ?? "确定")

        v.leftCallBack = { [weak self] in
            guard let `self` = self else{ return }
            self.dismissCallBack?()
            self.dismiss(animated: true, completion: nil)
        }
        
        v.rightCallBack = { [weak self] in
            guard let `self` = self else{ return }
            self.pickerCallBack?(self.pickerDate)
            self.dismissCallBack?()
            self.dismiss(animated: true, completion: nil)
        }
        
        return v
    }()
    
    fileprivate lazy var picker: UIDatePicker = {
        let p = UIDatePicker()
        p.timeZone = TimeZone.init(identifier: "CCD")
        p.locale = Locale(identifier: "zh_CN")
        p.setValue(DatePicker.pickerTextColor ?? .black, forKey: "textColor")

        if #available(iOS 13.4, *) {
            p.preferredDatePickerStyle = .wheels
        }
        p.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        return p
    }()
    
    public convenience init(mode: UIDatePicker.Mode) {
        self.init()
        picker.datePickerMode = mode
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
            m.height.equalTo(HeadBar.barHeight ?? 45)
        }
         
        view.addSubview(picker)
        picker.snp.makeConstraints { (make) in
            make.top.equalTo(header.snp.bottom).offset(5)
            make.left.equalToSuperview()//.offset(5)
            make.right.equalToSuperview()//.offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    @objc fileprivate func dateChanged(datePicker : UIDatePicker){
        let calendar = Calendar.current
        var comp = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: datePicker.date)
        comp.timeZone = TimeZone(secondsFromGMT: 0)
        pickerDate = calendar.date(from: comp) ?? Date.current()
    }
    
    public static func showPicker(mode: UIDatePicker.Mode,
                                  dateCallBack: @escaping PickerClosure,
                                  dismissCallBack: @escaping CloseClosure){
        
        let vc = UIDatePickerVC(mode: mode)
        vc.pickerCallBack = dateCallBack
        vc.dismissCallBack = dismissCallBack
        var component = PresentedViewComponent(contentSize: CGSize(width: DatePicker.pickerWidth ?? UIScreen.main.bounds.width, height: DatePicker.pickerHeight ?? 300))
        component.destination = .bottomBaseline
        component.presentTransitionType = .translation(origin: .bottomOutOfLine)
        vc.presentedViewComponent = component
        Show.currentViewController()?.presentViewController(vc)
    }
    
}
