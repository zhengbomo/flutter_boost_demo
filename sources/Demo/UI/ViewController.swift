//
//  ViewController.swift
//  Demo
//
//  Created by bomo on 2020/6/4.
//  Copyright © 2020 bomo. All rights reserved.
//

import UIKit


class ViewController: UIViewController, PopGestureEnable{
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.white
    }
    
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
    
    deinit {
        print("\(self.description)释放了")
    }
}


