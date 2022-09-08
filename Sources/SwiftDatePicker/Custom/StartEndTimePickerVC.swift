//
//  StartEndTimePickerVC.swift
//  SwiftDatePickerView
//
//  Created by iOS on 2020/12/1.
//

import UIKit
import SnapKit
public class StartEndTimePickerVC: UIViewController{
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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = DatePicker.pickerBackColor ?? .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        return view
    }()
    
    ///半窗样式: 位置
    fileprivate lazy var bottomLayout: NSLayoutConstraint = contentsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
 
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
            self.hide()
        }
        
        v.rightCallBack = { [weak self] in
            guard let `self` = self else{ return }
            self.pickerCallBack?(self.startDate, self.endDate)
            self.dismissCallBack?()
            self.hide()
        }
        
        return v
    }()
    
    fileprivate var startPickView : DatePickerView?
    fileprivate var endPickView : DatePickerView?
    
    public convenience init(startDate: Date, endDate: Date) {
        self.init()
        modalPresentationStyle = .overCurrentContext
        definesPresentationContext = true
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
    
    ///半窗样式: 动画
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ///VC出现后开始内容弹出动画
        showAnimtation()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        ///半窗样式: ┬┬┬┬┬┬┬┬┬┬
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
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
 
        contentsView.addSubview(header)
        header.snp.makeConstraints { (m) in
            m.top.left.right.equalToSuperview()
            m.height.equalTo(barConfig.barHeight ?? 45)
        }
        
        contentsView.addSubview(leftLabel)
        contentsView.addSubview(startPickView!)
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
        
        contentsView.addSubview(toLabel)
        toLabel.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.centerY.equalTo(startPickView!)
        }
        
        contentsView.addSubview(rightLabel)
        contentsView.addSubview(endPickView!)
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
    public static func showPicker(_ fromeVC: UIViewController,
                                  startDate: Date = Date(),
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
        fromeVC.present(vc, animated: false)
    }
}

///半窗样式处理
extension StartEndTimePickerVC{
    
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

