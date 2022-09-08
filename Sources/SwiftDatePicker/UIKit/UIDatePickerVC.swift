//
//  UIDatePickerVC.swift
//  SwiftDatePickerView
//
//  Created by iOS on 2020/10/26.
//

import UIKit
import SnapKit
public class UIDatePickerVC: UIViewController {
    ///半窗样式: 黑背景
    fileprivate lazy var dimmedView: UIView = {
        let view = UIView()
        view.frame = self.view.frame
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped)))
        return view
    }()
    ///半窗样式: 内容区域
    fileprivate lazy var contentsView: UIView = {
        let view = UIView()
        view.backgroundColor = .baseBGColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.setCorners(20, corners: .bothTop)
        return view
    }()
    
    ///半窗样式: 位置
    fileprivate lazy var bottomLayout: NSLayoutConstraint = contentsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
 
    fileprivate var dismissCallBack : CloseClosure?
    fileprivate var pickerCallBack : PickerClosure?
    fileprivate var pickerDate: Date = Date()

    fileprivate var barConfig: HeadBar!
    
    lazy var header: HeaderBar = {
        let v = HeaderBar(barConfig)

        v.leftCallBack = { [weak self] in
            guard let `self` = self else{ return }
            self.dismissCallBack?()
            self.hide()
        }
        
        v.rightCallBack = { [weak self] in
            guard let `self` = self else{ return }
            self.pickerCallBack?(self.pickerDate)
            self.dismissCallBack?()
            self.hide()
        }
        
        return v
    }()
    
    fileprivate lazy var picker: UIDatePicker = {
        let p = UIDatePicker()
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
        modalPresentationStyle = .overCurrentContext
        definesPresentationContext = true
        picker.datePickerMode = mode
    }
    
    ///半窗样式: 动画
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ///VC出现后开始内容弹出动画
        DispatchQueue.main.asyncAfter(delay: 0.1) {
            self.showAnimtation()
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        ///半窗样式: ┬┬┬┬┬┬┬┬┬┬
        view.backgroundColor = UIColor.black.alpha(0.3)
        view.addSubview(dimmedView)
        
        contentsView.transform = .init(translationX: 0, y: view.frame.height)
        view.addSubview(contentsView)
        NSLayoutConstraint.activate([
            contentsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentsView.heightAnchor.constraint(equalToConstant: DatePicker.pickerHeight ?? 300),
            bottomLayout
        ])
        
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(contentsViewPanGestured))
        viewPan.delaysTouchesBegan = true
        viewPan.delaysTouchesEnded = true
        contentsView.addGestureRecognizer(viewPan)
        ///半窗样式: ┴┴┴┴┴┴┴┴┴┴┴┴
        ///
        contentsView.backgroundColor = DatePicker.pickerBackColor ?? .white
 
        contentsView.addSubview(header)
        header.snp.makeConstraints { (m) in
            m.top.left.right.equalToSuperview()
            m.height.equalTo(barConfig.barHeight ?? 45)
        }
         
        contentsView.addSubview(picker)
        picker.snp.makeConstraints { (make) in
            make.top.equalTo(header.snp.bottom).offset(5)
            make.left.equalToSuperview()//.offset(5)
            make.right.equalToSuperview()//.offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    @objc fileprivate func dateChanged(datePicker : UIDatePicker){
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: datePicker.date)
        pickerDate = calendar.date(from: comp) ?? Date()
    }
    
    
    /// 弹出UIDatePickerVC
    /// - Parameters:
    ///   - mode: UIDatePicker.Mode 系统UIDatePicker的样式
    ///   - selectDate: 已选定时间
    ///   - headConfig: 顶部Bar适配器回调
    ///   - dateCallBack: 选择日期回调
    ///   - dismissCallBack: 收起视图回调
    public static func showPicker(_ fromeVC: UIViewController,
                                  mode: UIDatePicker.Mode,
                                  selectDate: Date = Date(),
                                  headConfig: HeadBarConfig,
                                  dateCallBack: @escaping PickerClosure,
                                  dismissCallBack: @escaping CloseClosure){
        
        let bar = HeadBar()
        headConfig(bar)
        let vc = UIDatePickerVC(mode: mode)
        vc.picker.date = selectDate
        vc.barConfig = bar
        vc.pickerCallBack = dateCallBack
        vc.dismissCallBack = dismissCallBack
        fromeVC.present(vc, animated: false) 
    }
    
}

///半窗样式处理
extension UIDatePickerVC{
    
    private func showAnimtation() {
        dimmedView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            self.dimmedView.alpha = 0.5
            self.contentsView.transform = .init(translationX: 0, y: 0)
        }
    }
    
    public func hide() {
//        view.endEditing(true)
        UIView.animate(withDuration: 0.25) {
            self.dimmedView.alpha = 0.0
            self.contentsView.transform = .init(translationX: 0, y: self.view.frame.height)
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    
    @objc private func dimmedViewTapped(_ sender: UITapGestureRecognizer) {
        hide()
//        view.endEditing(true)
    }
    
    @objc private func contentsViewPanGestured(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: contentsView)
        let translationY = translation.y
        let velocity = sender.velocity(in: contentsView)
        switch sender.state {
        case .ended:
            
            if (velocity.y > 200 && translationY > 0) || translationY > 200 {
                self.hide()
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.contentsView.transform = .init(translationX: 0, y: 0)
                }
            }
            
        default:
            if translationY > 0 {
                contentsView.transform = .init(translationX: 0, y: translationY)
            }
        }
    }

}

