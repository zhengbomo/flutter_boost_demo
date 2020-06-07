//
//  ViewManager.swift
//  Demo
//
//  Created by bomo on 2020/6/4.
//  Copyright © 2020 bomo. All rights reserved.
//

import UIKit


struct ViewManager {
    static var mainTabVC: MainTabVC?
    
    static func login() {
        self.mainTabVC?.reload()
    }
    
    static func logout() {
        let vc = LoginVC()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        self.mainTabVC?.present(navVC, animated: true, completion: {
            self.mainTabVC?.clean()
        })
    }
    
}
