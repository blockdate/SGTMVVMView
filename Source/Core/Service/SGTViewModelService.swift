//
//  SGTViewModelPageRouteService.swift
//  SGTReactView
//
//  Created by 磊吴 on 16/8/11.
//  Copyright © 2016年 磊吴. All rights reserved.
//

import Foundation
import MBProgressHUD

open class SGTViewModelPageRouteService: NSObject, SGTMVVMPageRouteServicesProtocol {
    
    open var navigationStack: SGTMVVMNavControllerStack
    
    /// the top viewcontroller on window
    weak open var topViewController: UIViewController? {
        return navigationStack.topNavigationController?.topViewController
    }
    
    override public init() {
        navigationStack = SGTMVVMNavControllerStack()
        super.init()
    }
    
    /**
     展示提示信息
     
     - parameter text: 提示消息
     */
    open func showHint(_ text:String?) {
        if let window = UIApplication.shared.keyWindow {
            window.endEditing(true)
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.isUserInteractionEnabled = false
            hud.mode = MBProgressHUDMode.text
            hud.label.text = text ?? ""
            hud.margin = 10
            hud.offset.y = SGTUtilScreenSize.screenHeight>400 ? 180:130
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1.5)
        }
    }
    //  MARK: - 界面切换动作
    open func resetRootViewModel(_ viewModel: SGTMVVMViewModelProtocol) {
        let vc = SGTMVVMPageRouter.viewControllerForViewModel(viewModel)
        navigationStack.resetRootViewController(vc)
    }
    /**
     push 动作
     
     - parameter viewModel: push的VM
     - parameter animated:  是否动画
     */
    open func pushViewModel(_ viewModel: SGTMVVMViewModelProtocol, animated: Bool) {
        navigationStack.pushViewModel(viewModel, animated: animated)
    }
    
    /**
     popRoot动作
     
     - parameter animated: 是否动画
     */
    open func popToRootViewModel(_ animated: Bool) {
        navigationStack.popToRootViewModel(animated)
    }
    
    /**
     pop 动作
     
     - parameter animated: 是否动画
     */
    open func popViewModel(_ animated: Bool) {
        navigationStack.popViewModel(animated)
    }
    
    /**
     present 动作
     
     - parameter viewModel: 需要present的VM
     - parameter animated:  是否动画
     */
    open func presentViewModel(_ viewModel:SGTMVVMViewModelProtocol, animated:Bool) {
        navigationStack.presentViewModel(viewModel, animated: animated)
    }
    
    /**
     dismiss 动作
     
     - parameter animated: 是否动画
     */
    open func dismissViewModel(_ animated:Bool) {
        navigationStack.dismissViewModel(animated)
    }
}
