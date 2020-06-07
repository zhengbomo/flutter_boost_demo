//
//  HomeVC.swift
//  Demo
//
//  Created by bomo on 2020/6/4.
//  Copyright © 2020 bomo. All rights reserved.
//

import UIKit
import Then
import SnapKit
import Flutter
import flutter_boost

class HomeVC: ViewController {
    override func loadView() {
        super.loadView()
        
        self.navigationItem.title = "主页"
        
        let sv = UIStackView().then {
            $0.spacing = 10
            $0.axis = .vertical
            self.view.addSubview($0)
            $0.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
            }
        }
        sv.addArrangedSubview(self.createButton(title: "push native page", selector: #selector(nativePage)))
        sv.addArrangedSubview(self.createButton(title: "push flutter home page", selector: #selector(pushFlutterHomePage)))
        sv.addArrangedSubview(self.createButton(title: "present flutter home page", selector: #selector(presentFlutterHomePage)))
        sv.addArrangedSubview(self.createButton(title: "flutter page with native bar", selector: #selector(flutterBarPage)))
        sv.addArrangedSubview(self.createButton(title: "flutter me page", selector: #selector(flutterMePage)))
    }
    
    @objc private func nativePage() {
        let vc = HomeVC()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func pushFlutterHomePage() {
        let vc = FlutterVC();
        vc.setName("home", params: [:]);
        NavigationHelper.nav2VC(vc, navVC: self.navigationController)
    }

    @objc private func presentFlutterHomePage() {
        let vc = FlutterVC();
        
        vc.setName("home", params: [:]);
        let navVC = UINavigationController(rootViewController: vc)
        // 需要设置成全屏，不然会有延迟释放问题
        navVC.modalPresentationStyle = .fullScreen
        NavigationHelper.presentVC(navVC)
    }
    
    @objc private func flutterBarPage() {
        let vc = NavigationBarFlutterVC();
        vc.setName("content", params: [:]);
        NavigationHelper.nav2VC(vc, navVC: self.navigationController)
    }
    
    @objc private func flutterMePage() {
        let vc = FlutterVC();
        vc.setName("me", params: [:]);
        NavigationHelper.nav2VC(vc, navVC: self.navigationController)
    }
    
    private func createButton(title: String, selector: Selector) -> UIButton {
        let button = UIButton(type: .custom).then {
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(UIColor.blue, for: .normal)
        }
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
}
