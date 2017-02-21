//
//  UIViewController+HUD.swift
//  YiDang-OC
//
//  Created by 磊吴 on 15/10/19.
//  Copyright © 2015年 block. All rights reserved.
//

import UIKit
import MBProgressHUD

public extension UIViewController {
    
    
    public func showHint(_ hint: String) {
//        let v = self.view
//        v.endEditing(true)
        if let v = UIApplication.shared.keyWindow {
            v.endEditing(true)
            let hud = MBProgressHUD.showAdded(to: v, animated: true)
            hud.isUserInteractionEnabled = false
            hud.mode = MBProgressHUDMode.text
            hud.label.text = hint
            hud.margin = 10
            hud.offset.y = SGTUtilScreenSize.screenHeight>400 ? 180:130
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1.5)
        }
    }
    
    public func showError(_ error: String) {
        self.showHint(error)
        //        TWMessageBarManager.sharedInstance().showMessageWithTitle("抱歉", description: error, type: .Error, duration: 1.5)
    }
    
    public func showInfo(_ msg: String) {
        //        TWMessageBarManager.sharedInstance().showMessageWithTitle("通知", description: msg, type: .Info, duration: 1.5)
    }
    
    public func showSuccess(_ success: String) {
        //        TWMessageBarManager.sharedInstance().showMessageWithTitle("恭喜", description: success, type: .Success, duration: 1.5)
    }
    
}
