//
//  MeVC.swift
//  Demo
//
//  Created by bomo on 2020/6/4.
//  Copyright © 2020 bomo. All rights reserved.
//

import UIKit
import Then
import SnapKit


class MeVC: ViewController {
    override func loadView() {
        super.loadView()
        
        self.tabBarItem.title = "Me"
        
        self.navigationItem.title = "我的"
        let button = UIButton(type: .custom).then {
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            $0.setTitle("退出登录", for: .normal)
            $0.setTitleColor(UIColor.blue, for: .normal)
            self.view.addSubview($0)
            $0.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
            }
        }
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    @objc private func logout() {
        ViewManager.logout()
    }
}
