//
//  SGTMVVMNavControllerStack.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/15.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit

public protocol SGTAppDelegateProtocol {
    var window: UIWindow? {get set}
}

open class SGTMVVMNavControllerStack: NSObject {
    
    open weak var topNavigationController: UINavigationController? {
        return self.navigationControllers.last
    }
    public fileprivate(set) var navigationControllers:Array<UINavigationController>
    
    override public init() {
        navigationControllers = Array<UINavigationController>()
        super.init()
    }
    
    open func resetRootViewController(_ viewController: UIViewController) {
        if viewController.isKind(of: UITabBarController.self) {
            let tab = viewController as! UITabBarController
            if let nav = tab.viewControllers?.safeGet(0) {
                if nav.isKind(of: UINavigationController.self) {
                    self.navigationControllers.removeAll()
                    self.pushNavigationControllers(nav as! SGTMVVMNavigationController)
                    let appdelegate = UIApplication.shared.delegate as! SGTAppDelegateProtocol
                    appdelegate.window?.endEditing(true)
                    appdelegate.window?.rootViewController = nil
                    appdelegate.window?.rootViewController = viewController
                    
                }else{
                    SGTLogError("tabbarcontroller 子VC 需要为 SGTCustomNavigationController")
                }
            }else {
                SGTLogError("tabbarcontroller 不存在 viewControllers ")
            }
            
        }else if viewController.isKind(of: SGTMVVMViewController.self){
            let nav = SGTMVVMNavigationController(rootViewController: viewController);
            self.navigationControllers.removeAll()
            self.pushNavigationControllers(nav)
            let appdelegate = UIApplication.shared.delegate as! SGTAppDelegateProtocol
            
            appdelegate.window?.endEditing(true)
            
            appdelegate.window?.rootViewController = nil
            
            appdelegate.window?.rootViewController = nav
        }else {
            SGTLogError("暂未加入对应VC的判断")
        }
    }
    
    open func resetRootNavigationController(_ nav: UINavigationController) {
        self.navigationControllers.removeAll()
        SGTLogDebug("reset root navigationcontroller")
        self.navigationControllers.append(nav)
    }
    
    open func pushNavigationControllers(_ nav: UINavigationController) {
        if navigationControllers.contains(nav) {
            return
        }
        navigationControllers.append(nav)
        SGTLogDebug("push navigationcontroller now has \(navigationControllers.count)")
    }
    
    @discardableResult open func popNavigationControllers() ->UINavigationController?{
        SGTLogDebug("pop navigationcontroller now has \(navigationControllers.count)")
        return navigationControllers.popLast()
    }
    
    @discardableResult open func pushViewModel(_ viewModel: SGTMVVMViewModelProtocol, animated: Bool) ->UIViewController? {
        let vc = SGTMVVMPageRouter.viewControllerForViewModel(viewModel)
        vc.hidesBottomBarWhenPushed = true
        if vc is SGTMVVMViewController {
            (vc as! SGTMVVMViewController).pushed.consume(true)
        }
        topNavigationController?.pushViewController( vc, animated: animated)
        return vc
    }
    
    open func popToRootViewModel(_ animated: Bool) {
        let _ = topNavigationController?.popToRootViewController(animated: animated)
    }
    
    @discardableResult open func popViewModel(_ animated: Bool) ->UIViewController?{
        let _ = topNavigationController?.popViewController(animated: animated)
        return topNavigationController?.topViewController
    }
    
    @discardableResult open func presentViewModel(_ viewModel:SGTMVVMViewModelProtocol, animated:Bool) ->UIViewController?{
        let vc = SGTMVVMPageRouter.viewControllerForViewModel(viewModel)
        let nav = SGTMVVMNavigationController(rootViewController: vc)
        topNavigationController?.present(nav, animated: animated, completion: {[weak self] () -> Void in
            guard self != nil else {return}
            self?.pushNavigationControllers(nav)
        })
        return vc
    }
    
    open func dismissViewModel(_ animated:Bool) {
        topNavigationController?.dismiss(animated: animated, completion: {[weak self] () -> Void in
            guard self != nil else {return}
            let _ = self?.popNavigationControllers()
        })
    }
    
}
