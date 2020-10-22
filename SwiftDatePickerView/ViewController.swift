//
//  ViewController.swift
//  SwiftDatePickerView
//
//  Created by iOS on 2020/10/21.
//

import UIKit
import SnapKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DatePicker.titleString = "选择日期/时间"
        DatePicker.barColor = .orange
        
        let pick = DatePickerView(type: .pickerDateHourMinute, minYear: 1999, maxYear: 2030) { (date) in
            print("\(date)")
        }

        view.addSubview(pick)
        pick.snp.makeConstraints { (m) in
            m.left.right.equalToSuperview()
            m.centerY.equalToSuperview()
            m.height.equalTo(200)
        }
        
        let btn = UIButton(frame: .init(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 60))
        btn.setTitle("点击弹窗", for: .normal)
        btn.backgroundColor = .orange
        btn.addTarget(self, action: #selector(action), for: .touchUpInside)
        view.addSubview(btn)
    }

    @objc func action(){
        DatePickerVC.showPicker(pickerType: .pickerDate) { (date) in
            print("\(String(describing: date))")
        }
    }
}

