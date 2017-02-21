//
//  SGTMVVMReuseViewModelProtocol.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/15.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit

public protocol SGTMVVMPageRouteServicesProtocol {
    /// for vm navigation control
    var navigationStack: SGTMVVMNavControllerStack{get set}
    /// top viewcontroller on window
    weak var topViewController: UIViewController? {get}
    /**
     show a toast
     
     - author: block
     
     - parameter text: toast text
     */
    func showHint(_ text:String?)
    /**
     reset root ViewModel
     such as keywindow.rootViewController = viewModelController
     
     - author: block
     
     - parameter viewModel: target controller viewmodel
     */
    func resetRootViewModel(_ viewModel: SGTMVVMViewModelProtocol)
    /**
     push a viewModel
     such as pushViewController
     
     - author: block
     
     - parameter viewModel: target controller viewmodel
     - parameter animated:  push animated
     */
    func pushViewModel(_ viewModel: SGTMVVMViewModelProtocol, animated: Bool)
    /**
     pop current navigation stack to root viewModel
     such as topViewController.navigationController?.popToRootViewController(animated:)
     
     - author: block
     
     - parameter animated: pop animated
     */
    func popToRootViewModel(_ animated: Bool)
    /**
     pop current navigation stack top viewModel
     such as topViewController.navigationController?.popViewController(animated:)
     
     - author: block
     
     - parameter animated: pop animated
     */
    func popViewModel(_ animated: Bool)
    /**
     present a viewModel Controller base on current NavigationController
     such as topViewController.navigationController?.presentViewController()
     
     - author: block
     
     - parameter viewModel: target Controller ViewModel
     - parameter animated:  animated
     */
    func presentViewModel(_ viewModel:SGTMVVMViewModelProtocol, animated:Bool)
    /**
     dismiss the topViewController
     
     - author: block
     
     - parameter animated: animated
     */
    func dismissViewModel(_ animated:Bool)
}
