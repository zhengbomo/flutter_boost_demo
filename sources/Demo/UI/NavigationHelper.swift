//
//  NavigationHelper.swift
//  Demo
//
//  Created by bomo on 2020/6/5.
//  Copyright © 2020 bomo. All rights reserved.
//

import UIKit


final class NavigationHelper {
    static func nav2VC(_ vc: UIViewController, navVC: UINavigationController? = nil) {
        vc.hidesBottomBarWhenPushed = true
        let navVC = navVC ?? self.getTopVC().navigationController
        navVC?.pushViewController(vc, animated: true)
    }
    
    static func presentVC(_ vc: UIViewController, baseVC: UIViewController? = nil) {
        let baseVC = baseVC ?? self.getTopVC()
        baseVC.present(vc, animated: true, completion: nil)
    }
    
    static func pop() {
        let navVC = self.getTopVC().navigationController
        navVC?.popViewController(animated: true)
    }
    
    static func dismiss() {
        let topVC = self.getTopVC()
        topVC.dismiss(animated: true, completion: nil)
    }
        
    static func getTopVC() -> UIViewController {
        let vc = UIApplication.shared.delegate!.window!!.rootViewController!
        return getTopVC(vc)
    }
    
    private static func getTopVC(_ base: UIViewController) -> UIViewController {
        if let presentVC = base.presentedViewController {
            return self.getTopVC(presentVC)
        } else if let tabVC = base as? UITabBarController, let selVC = tabVC.selectedViewController {
            return self.getTopVC(selVC)
        } else if let navVC = base as? UINavigationController, let topVC = navVC.topViewController {
            return self.getTopVC(topVC)
        } else {
            return base
        }
    }
    
}
