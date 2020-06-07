//
//  LoginVC.swift
//  Demo
//
//  Created by bomo on 2020/6/4.
//  Copyright © 2020 bomo. All rights reserved.
//


import UIKit
import Then
import SnapKit


class LoginVC: ViewController {
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "主页"
        let button = UIButton(type: .custom).then {
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            $0.setTitle("登录", for: .normal)
            $0.setTitleColor(UIColor.blue, for: .normal)
            self.view.addSubview($0)
            $0.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
            }
        }
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    @objc private func login() {
        self.dismiss(animated: true) {
            ViewManager.login()
        }
    }
}
