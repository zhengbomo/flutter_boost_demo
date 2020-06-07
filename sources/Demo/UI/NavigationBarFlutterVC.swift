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
    private var cancelable: FLBVoidCallback?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "native bar"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "test", style: .done, target: self, action: #selector(showToast))
        
        // 监听flutter的消息
        cancelable = FlutterBoostPlugin.sharedInstance().addEventListener({ [weak self] (name, arguments) in
            guard let self = self else { return }
            
            if let arguments = arguments, let msg = arguments["message"] as? String {
                let vc = UIAlertController(title: "tip", message: msg, preferredStyle: .alert)
                vc.addAction(UIAlertAction(title: "cancel", style: .default, handler: nil))
                self.present(vc, animated: true, completion: nil)
            }
        }, forName: "alert");
    }
    
    deinit {
        cancelable?()
    }
    
    @objc private func showToast() {
        // 发送消息到flutter
        FlutterBoostPlugin.sharedInstance().sendEvent("showToast", arguments: ["message": "native消息"]);
    }
}
