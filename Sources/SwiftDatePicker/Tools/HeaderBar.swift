//
//  HeaderBar.swift
//  ClassTable
//
//  Created by iOS on 2020/10/9.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit
import SnapKit

public enum BarStyle {
    case titleCenter
    case titleLeft
}

public class HeaderBar: UIView {

    fileprivate var barConfig: HeadBar!

    public var leftCallBack : (() -> Void)?
    public var rightCallBack : (() -> Void)?
    
    public convenience init(_ config: HeadBarConfig) {
        self.init()
        let bar = HeadBar()
        config(bar)
        barConfig = bar
        setupStyle()
    }
    
    public convenience init(_ bar: HeadBar) {
        self.init()
        barConfig = bar
        setupStyle()
    }
    
    func setupStyle(){
        titleLabel.text = barConfig.titleString
        
        leftButton.titleLabel?.font = barConfig.buttonFont ?? .systemFont(ofSize: 16)
        leftButton.setTitleColor(barConfig.barButtonColor ?? .black, for: .normal)
        leftButton.setTitleColor(.lightGray, for: .highlighted)
        leftButton.setTitle(barConfig.leftString, for: .normal)
        leftButton.setImage(barConfig.leftNorImage, for: .normal)
        leftButton.setImage(barConfig.leftHigImage, for: .highlighted)

        rightButton.titleLabel?.font = barConfig.buttonFont ?? .systemFont(ofSize: 16)
        rightButton.setTitleColor(barConfig.barButtonColor ?? .black, for: .normal)
        rightButton.setTitleColor(.lightGray, for: .highlighted)
        rightButton.setTitle(barConfig.rightString, for: .normal)
        rightButton.setImage(barConfig.rightNorImage, for: .normal)
        rightButton.setImage(barConfig.rightHigImage, for: .highlighted)
        
        setupViews()
    }

    fileprivate lazy var titleLabel: UILabel = {
        let lab = UILabel()
        lab.font = barConfig.titleFont ?? .systemFont(ofSize: 16)
        lab.textColor = barConfig.barTitleColor ?? .black
        lab.numberOfLines = 0
        lab.adjustsFontSizeToFitWidth = true
        lab.minimumScaleFactor = 0.5
        return lab
    }()
    
    fileprivate lazy var leftButton : UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(leftAction), for: .touchUpInside)
        return b
    }()
    
    fileprivate lazy var rightButton : UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(rightAction), for: .touchUpInside)
        return b
    }()
    
    func setupViews(){
        
        backgroundColor = barConfig.barColor ?? .white
        
        addSubview(titleLabel)
        addSubview(leftButton)
        addSubview(rightButton)
        
        rightButton.snp.makeConstraints { (m) in
            m.centerY.equalToSuperview()
            m.right.equalToSuperview().offset(-20)
            m.height.equalTo(40)
            if let w = barConfig?.rightWidth, w > 0 {
                m.width.equalTo(w)
            }
        }
        
        titleLabel.snp.makeConstraints { (m) in
            m.centerY.equalToSuperview()
            switch barConfig.barStyle{
            case .titleLeft:
                m.left.equalToSuperview().offset(20)
            case .titleCenter:
                m.centerX.equalToSuperview()
            }
        }
        
        leftButton.snp.makeConstraints { (m) in
            m.centerY.equalToSuperview()
            m.height.equalTo(40)
            if let w = barConfig.leftWidth, w > 0 {
                m.width.equalTo(w)
            }
            switch barConfig.barStyle{
            case .titleLeft:
                m.right.equalTo(rightButton.snp.left).offset(-10)
            case .titleCenter:
                m.left.equalToSuperview().offset(20)
            }
        }
        
    }
    
    @objc func leftAction(){
        leftCallBack?()
    }
    
    @objc func rightAction(){
        rightCallBack?()
    }
}
