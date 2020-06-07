//
//  FlutterVC.swift
//  Demo
//
//  Created by bomo on 2020/6/4.
//  Copyright © 2020 bomo. All rights reserved.
//

import Flutter
import CWActionSheet
import flutter_boost
import TZImagePickerController


class FlutterVC: FLBFlutterViewContainer, PopGestureEnable {    
    var popGestureRecognizerEnabled = true {
        didSet {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = popGestureRecognizerEnabled
        }
    }
    
    // 由于navigationController是多个viewController共享的，所以在页面跳转的时候，需要进行更新
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         self.navigationController?.interactivePopGestureRecognizer?.isEnabled = self.popGestureRecognizerEnabled
    }
    
    override func loadView() {
        super.loadView()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    deinit {
        print("\(self.description)释放了")
    }
}
