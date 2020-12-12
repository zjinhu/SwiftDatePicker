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

    fileprivate var barStyle: BarStyle = .titleCenter

    public var leftCallBack : (() -> Void)?
    public var rightCallBack : (() -> Void)?
    
    public convenience init(style: BarStyle, title: String, left: String, right: String) {
        self.init()
        
        barStyle = style

        leftButton.titleLabel?.font = HeadBar.buttonFont ?? .systemFont(ofSize: 16)
        leftButton.setTitleColor(HeadBar.barButtonColor ?? .black, for: .normal)
        leftButton.setTitleColor(.lightGray, for: .highlighted)
        
        rightButton.titleLabel?.font = HeadBar.buttonFont ?? .systemFont(ofSize: 16)
        rightButton.setTitleColor(HeadBar.barButtonColor ?? .black, for: .normal)
        rightButton.setTitleColor(.lightGray, for: .highlighted)
        
        titleLabel.text = title
        leftButton.setTitle(left, for: .normal)
        rightButton.setTitle(right, for: .normal)
        
        setupViews()
    }
    
    public convenience init(style: BarStyle,
                            title: String,
                            leftNor: UIImage?,
                            rightNor: UIImage?,
                            leftHig: UIImage?,
                            rightHig: UIImage?) {
        self.init()
        
        barStyle = style

        titleLabel.text = title
        
        leftButton.setImage(leftNor, for: .normal)
        leftButton.setImage(leftHig, for: .highlighted)
        rightButton.setImage(rightNor, for: .normal)
        rightButton.setImage(rightHig, for: .highlighted)
        
        setupViews()
    }

    fileprivate lazy var titleLabel: UILabel = {
        let lab = UILabel()
        lab.font = HeadBar.titleFont ?? .systemFont(ofSize: 16)
        lab.textColor = HeadBar.barTitleColor ?? .black
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
        
        backgroundColor = HeadBar.barColor ?? .white
        
        addSubview(titleLabel)
        addSubview(leftButton)
        addSubview(rightButton)
        
        rightButton.snp.makeConstraints { (m) in
            m.centerY.equalToSuperview()
            m.right.equalToSuperview().offset(-20)
            m.width.greaterThanOrEqualTo(40)
            m.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { (m) in
            m.centerY.equalToSuperview()
            switch barStyle{
            case .titleLeft:
                m.left.equalToSuperview().offset(20)
            case .titleCenter:
                m.centerX.equalToSuperview()
            }
        }
        
        leftButton.snp.makeConstraints { (m) in
            m.centerY.equalToSuperview()
            m.width.greaterThanOrEqualTo(40)
            m.height.equalTo(40)
            switch barStyle{
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
