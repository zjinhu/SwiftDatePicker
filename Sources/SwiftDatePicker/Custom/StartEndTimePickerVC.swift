//
//  StartEndTimePickerVC.swift
//  SwiftDatePickerView
//
//  Created by iOS on 2020/12/1.
//

import UIKit
import SwiftShow
import SnapKit
public class StartEndTimePickerVC: UIViewController, PresentedViewType{
    public var presentedViewComponent: PresentedViewComponent?
    
    fileprivate var dismissCallBack : CloseClosure?
    fileprivate var pickerCallBack : TimeIntervalClosure?
    
    fileprivate var startDate: Date = Date()
    fileprivate var endDate: Date = Date()
    
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
            self.pickerCallBack?(self.startDate, self.endDate)
            self.dismissCallBack?()
            self.dismiss(animated: true, completion: nil)
        }
        
        return v
    }()
    
    fileprivate var startPickView : DatePickerView?
    fileprivate var endPickView : DatePickerView?
    
    public convenience init(startDate: Date, endDate: Date) {
        self.init()
        startPickView = DatePickerView(type: .pickerTime,
                                       selectDate: startDate,
                                       showUnit: false,
                                       callBack: { [weak self] (date) in
                                        guard let `self` = self else{ return }
                                        self.startDate = date
                                       })
        
        endPickView = DatePickerView(type: .pickerTime,
                                     selectDate: endDate,
                                     showUnit: false,
                                     callBack: { [weak self] (date) in
                                        guard let `self` = self else{ return }
                                        self.endDate = date
                                     })
    }
    

    
    lazy var toLabel: UILabel = {
        let lab = UILabel()
        lab.text = "到"
        lab.font = .systemFont(ofSize: 16)
        lab.textColor = DatePicker.pickerTextColor ?? .black
        return lab
    }()
    
    lazy var leftLabel: UILabel = {
        let lab = UILabel()
        lab.text = ":"
        lab.font = .systemFont(ofSize: 16)
        lab.textColor = DatePicker.pickerTextColor ?? .black
        return lab
    }()
    
    lazy var rightLabel: UILabel = {
        let lab = UILabel()
        lab.text = ":"
        lab.font = .systemFont(ofSize: 16)
        lab.textColor = DatePicker.pickerTextColor ?? .black
        return lab
    }()
    
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
        
        view.addSubview(leftLabel)
        view.addSubview(startPickView!)
        startPickView?.snp.makeConstraints { (make) in
            make.top.equalTo(header.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(view.snp.centerX).offset(-20)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        leftLabel.snp.makeConstraints { (m) in
            m.centerX.equalTo(startPickView!)
            m.centerY.equalTo(startPickView!)
        }
        
        view.addSubview(toLabel)
        toLabel.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.centerY.equalTo(startPickView!)
        }
        
        view.addSubview(rightLabel)
        view.addSubview(endPickView!)
        endPickView?.snp.makeConstraints { (make) in
            make.top.equalTo(header.snp.bottom).offset(5)
            make.left.equalTo(view.snp.centerX).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        rightLabel.snp.makeConstraints { (m) in
            m.centerX.equalTo(endPickView!)
            m.centerY.equalTo(endPickView!)
        }
    }
    
    /// 弹出选择起始+结束时间
    /// - Parameters:
    ///   - startDate: 已选定开始时间
    ///   - endDate: 已选定结束时间
    ///   - headConfig: 顶部Bar适配器回调
    ///   - dateCallBack: 选择日期回调
    ///   - dismissCallBack: 收起视图回调
    public static func showPicker(startDate: Date = Date(),
                                  endDate: Date = Date(),
                                  headConfig: HeadBarConfig,
                                  dateCallBack: @escaping TimeIntervalClosure,
                                  dismissCallBack: @escaping CloseClosure){
        let bar = HeadBar()
        headConfig(bar)
        let vc = StartEndTimePickerVC(startDate: startDate, endDate: endDate)
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

