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
    
    fileprivate var dismissCallBack : CloseClosure?
    fileprivate var pickerCallBack : PickerClosure?
    
    fileprivate var pickView: DatePickerView?
    fileprivate var pickerDate: Date = Date()
    fileprivate var barConfig: HeadBar!
    
    lazy var header: HeaderBar = {
        let v = HeaderBar(barConfig)

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

    public convenience init(pickerType: DatePickerStyle) {
        self.init()
        pickView = DatePickerView(type: pickerType,
                                  minYear: DatePicker.minYear ?? Date().getYear(),
                                  maxYear: DatePicker.maxYear ?? Date().getYear() + 5,
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
            m.height.equalTo(barConfig.barHeight ?? 45)
        }
         
        view.addSubview(pickView!)
        pickView?.snp.makeConstraints { (make) in
            make.top.equalTo(header.snp.bottom).offset(5)
            make.left.equalToSuperview()//.offset(5)
            make.right.equalToSuperview()//.offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }

    /// 弹出自定义DatePickerVC
    /// - Parameters:
    ///   - pickerType: DatePickerStyle的样式
    ///   - headConfig: 顶部Bar适配器回调
    ///   - dateCallBack: 选择日期回调
    ///   - dismissCallBack: 收起视图回调
    public static func showPicker(pickerType: DatePickerStyle = .pickerDate,
                                  headConfig: HeadBarConfig,
                                  dateCallBack: @escaping PickerClosure,
                                  dismissCallBack: @escaping CloseClosure){
        let bar = HeadBar()
        headConfig(bar)
        let vc = DatePickerVC(pickerType: pickerType)
        vc.barConfig = bar
        vc.pickerCallBack = dateCallBack
        vc.dismissCallBack = dismissCallBack
        var component = PresentedViewComponent(contentSize: CGSize(width: DatePicker.pickerWidth ?? UIScreen.main.bounds.width, height: DatePicker.pickerHeight ?? 300))
        component.destination = .bottomBaseline
        component.presentTransitionType = .translation(origin: .bottomOutOfLine)
        vc.presentedViewComponent = component
        Show.currentViewController()?.presentViewController(vc)
    }
}

