//
//  FlutterManager.swift
//  Demo
//
//  Created by bomo on 2020/6/4.
//  Copyright © 2020 bomo. All rights reserved.
//

import Foundation
import Flutter
import FlutterPluginRegistrant
import flutter_boost
import CWActionSheet
import TZImagePickerController

struct FlutterManger {
    static func setup() {
        // 用于处理flutter发送的页面跳转消息
        let router = PlatformRouterImp.init();
        FlutterBoostPlugin.sharedInstance().startFlutter(with: router, onStart: { (engine) in
            
            // 配置channel
            let batteryChannel = FlutterMethodChannel(name: "myflutter_method_channel",
                                                      binaryMessenger: engine.binaryMessenger)
                  
            batteryChannel.setMethodCallHandler({ (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                switch call.method {
                case "flutter_page_changed":
                    // 修改native页面的侧滑
                    if let argument = call.arguments as? [String: Any],
                        let canPop = argument["canPop"] as? Bool {
                        if var vc = NavigationHelper.getTopVC() as? PopGestureEnable {
                            vc.popGestureRecognizerEnabled = !canPop
                        }
                    }
                    result(nil)
                case "home_vc":
                    let vc = HomeVC()
                    NavigationHelper.nav2VC(vc)
                    result(nil)
                case "back_vc":
                    NavigationHelper.pop()
                    result(nil)
                case "pink_image":
                    if let picker = TZImagePickerController(maxImagesCount: 2, columnNumber: 4, delegate: nil) {
                        picker.didFinishPickingPhotosHandle = { (photos, assets, isSelectOriginPhoto) in
                            if let assets = assets as? [PHAsset] {
                                for asset in assets {
                                    print(asset.localIdentifier)
                                }
                            }
                            result("选择了\(photos?.count ?? 0)张图片")
                        }
                        picker.modalPresentationStyle = .fullScreen
                        NavigationHelper.getTopVC().present(picker, animated: true, completion: nil)
                    } else {
                        result(nil)
                    }
                case "alert":
                    let vc = UIAlertController(title: "测试弹窗", message: "测试弹窗", preferredStyle: .alert)
                    vc.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
                    NavigationHelper.getTopVC().present(vc, animated: true, completion: nil)
                    result(nil)
                case "action_sheet":
                    let clickedHandler = { (sheetView: ActionSheetView, index: Int) in
                        print("点击\(index)")
                    }
                    let title = "Default CWActionSheet"
                    let actionSheet = ActionSheetView(title: title,
                                                    cancelButtonTitle: "Cancel",
                                                    otherButtonTitles: ["Delete"],
                                                    clickedHandler: clickedHandler)
                    actionSheet.destructiveButtonIndex = 0
                    
                    actionSheet.show(in: NavigationHelper.getTopVC().view)
                    result(nil)
                    break
                default:
                    result(nil)
                }
            })
        })
    }
}




class PlatformRouterImp: NSObject, FLBPlatform {
    // 从flutter过来的跳转页面的消息
    func open(_ url: String, urlParams: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
        switch url {
        case "nativePage":
            let vc = HomeVC()
            NavigationHelper.nav2VC(vc)
        case "nativeFlutterPage":
            let vc = FlutterVC();
            vc.setName("home", params: urlParams);
            NavigationHelper.nav2VC(vc)
            completion(true);
        default:
            break
        }
    }
    
    func present(_ url: String, urlParams: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
        switch url {
        case "nativePage":
            let vc = HomeVC()
            NavigationHelper.presentVC(vc)
            completion(true);
        case "nativeFlutterPage":
            let vc = FlutterVC();
            vc.setName("home", params: urlParams);
            let navVC = UINavigationController(rootViewController: vc)
            NavigationHelper.presentVC(navVC)
            completion(true);
        default:
            completion(false);
        }
    }
    func close(_ uid: String, result: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
        let topVC = NavigationHelper.getTopVC()
        let presentVC = topVC.presentingViewController
        // 判断是否时present
        if let _ = presentVC {
            topVC.dismiss(animated: true, completion: { [unowned topVC] in
                topVC.removeFromParent()
            })
        } else {
            topVC.navigationController?.popViewController(animated: true)
        }
    }
}
