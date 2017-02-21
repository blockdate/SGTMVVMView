//
//  SGTMVVMControllerViewModel.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/15.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import enum Result.NoError

public struct SGTNavBarStyle: OptionSet {
    public let rawValue : Int
    public init(rawValue:Int){ self.rawValue = rawValue}
    
    //    defaul title
    static public let Default = SGTNavBarStyle(rawValue: 0)
    //    contain one search bar on title view
    static public let Search = SGTNavBarStyle(rawValue: 1)
}

public struct SGTNavItem {
    public var title: String?
    public var image: UIImage?
    public var selectCommand: CocoaAction<UIBarButtonItem>?
    public init(title:String?, image: UIImage?, selectCommand: CocoaAction<UIBarButtonItem>?) {
        self.title = title
        self.image = image
        self.selectCommand = selectCommand
    }
}

open class SGTMVVMControllerViewModel: SGTMVVMViewModel {
    
    open var titleText:String?
    
    open var backNavImage: UIImage? = UIImage.init(named: "nav_back")
    
    open override func viewClass() -> AnyClass {
        return SGTMVVMViewController.self
    }
    
    open var (willDisappearSignal,willDisappearObserver) = Signal<Any,NoError>.pipe()
    open var (didAppearSignal,didAppearObserver) = Signal<Any,NoError>.pipe()
    open var (willAppearSignal,willAppearObserver) = Signal<Any,NoError>.pipe()
    open var (didDisappearSignal,didDisappearObserver) = Signal<Any,NoError>.pipe()
    open var (didPopSignal,didPopObserver) = Signal<Any,NoError>.pipe()
    
    
    open var navBarStyle: SGTNavBarStyle = .Default
    
    /// if current controller was pushed left navitem will move to right
    open var leftNavItem: SGTNavItem?
    open var rightNavItem: SGTNavItem?
    
    open var navBackgroundColor: UIColor = SGTColor.system
    open var navTitleColor: UIColor = UIColor.white
    
    open var tabFocusColor: UIColor = SGTColor.system
    open var tabUnFocusColor: UIColor = SGTColor.lightGray
    
}
