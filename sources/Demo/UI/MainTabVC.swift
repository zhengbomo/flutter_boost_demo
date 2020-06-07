//
//  MainTabVC.swift
//  Demo
//
//  Created by bomo on 2020/6/4.
//  Copyright © 2020 bomo. All rights reserved.
//

import Foundation
import UIKit
import Then


class MainTabVC: UITabBarController {
    override func loadView() {
        super.loadView()
        
        ViewManager.mainTabVC = self
        self.reload()
    }
    
    func clean() {
        self.viewControllers?.forEach {
            $0.removeFromParent()
        }
        self.viewControllers = []
    }
    
    func reload() {
        self.clean()
        self.viewControllers = [
            UINavigationController(rootViewController: HomeVC()).then {
                $0.tabBarItem.title = "Home"
            },
            UINavigationController(rootViewController: MeVC()).then {
                $0.tabBarItem.title = "Me"
            },
        ]
    }
}
