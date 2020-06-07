//
//  NavigationBarFlutterVC.swift
//  Demo
//
//  Created by bomo on 2020/6/7.
//  Copyright © 2020 bomo. All rights reserved.
//

import Foundation
import flutter_boost

class NavigationBarFlutterVC: FlutterVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "native bar"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "test", style: .done, target: self, action: #selector(showToast))
    }
    
    @objc private func showToast() {
        FlutterBoostPlugin.sharedInstance().sendEvent("showToast", arguments: ["message": "native消息"]);
    }
}
