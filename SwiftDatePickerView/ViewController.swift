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

        let pick = DatePickerView(type: .pickerDateHourMinute, minYear: 1999, maxYear: 2030) { (date) in
            print("\(date)")
        }

        view.addSubview(pick)
        pick.snp.makeConstraints { (m) in
            m.left.right.equalToSuperview()
            m.bottom.equalToSuperview()
            m.height.equalTo(200)
        }
        
        
        //弹窗
        let btn = UIButton(frame: .init(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 60))
        btn.setTitle("点击弹窗StartEndTimePickerVC", for: .normal)
        btn.backgroundColor = .orange
        btn.addTarget(self, action: #selector(action), for: .touchUpInside)
        view.addSubview(btn)
        
        //弹窗
        let btn2 = UIButton(frame: .init(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 60))
        btn2.setTitle("点击弹窗UIDatePickerVC", for: .normal)
        btn2.backgroundColor = .orange
        btn2.addTarget(self, action: #selector(action2), for: .touchUpInside)
        view.addSubview(btn2)
        
        //弹窗
        let btn3 = UIButton(frame: .init(x: 0, y: 300, width: UIScreen.main.bounds.width, height: 60))
        btn3.setTitle("点击弹窗DatePickerVC", for: .normal)
        btn3.backgroundColor = .orange
        btn3.addTarget(self, action: #selector(action3), for: .touchUpInside)
        view.addSubview(btn3)
    }

    @objc func action(){

        StartEndTimePickerVC.showPicker { (bar) in
            bar.titleString = "选择时间"
            bar.barColor = .orange
            bar.leftString = "123123123"
            bar.rightString = "1212313213"
        } dateCallBack: { (start, end) in
            print("\(String(describing: start))--\(String(describing: end))")
        } dismissCallBack: {
            print("close")
        }

    }
    
    @objc func action2(){

        UIDatePickerVC.showPicker(mode: .dateAndTime) { (bar) in
            bar.titleString = "选择日期"
            bar.barColor = .orange
            bar.leftNorImage = UIImage(named: "image_cancle")
            bar.rightNorImage = UIImage(named: "image_done")
        } dateCallBack: { (date) in
            print("\(String(describing: date))")
        } dismissCallBack: {
            print("close")
        }

    }
    
    @objc func action3(){

        DatePickerVC.showPicker(pickerType: .pickerDateHourMinute) { (bar) in
            bar.titleString = "选择日期"
            bar.barColor = .orange
            bar.leftNorImage = UIImage(named: "image_cancle")
            bar.rightNorImage = UIImage(named: "image_done")
        } dateCallBack: { (date) in
            print("\(String(describing: date))")
        } dismissCallBack: {
            print("close")
        }

    }
}

