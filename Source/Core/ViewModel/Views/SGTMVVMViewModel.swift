//
//  SGTMVVMViewModel.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/15.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import enum Result.NoError

open class SGTMVVMViewModel: NSObject, SGTMVVMViewModelProtocol {
    
    open var frame: CGRect = CGRect.zero
    
    open var padding: UIEdgeInsets = UIEdgeInsets.zero
    
    open var (errorSignal, errorObserver) = Signal<NSError,NoError>.pipe()
    
    open var (executingSignal, executingObserver) = Signal<Bool, NoError>.pipe()
    
    open fileprivate(set) var pageRouteService: SGTMVVMPageRouteServicesProtocol = SGTMVVMInject.inject()
    
    public required init(service: SGTMVVMPageRouteServicesProtocol) {
        self.pageRouteService = service
        super.init()
        self.initialize()
    }
    
    required override public init() {
        super.init()
        self.initialize()
    }
    
    public var networkReachable = MutableProperty<Bool>(true)
    
    open func initialize(){}
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        SGTLogDebug("\(type(of: self)):\(#function)")
    }
    
    open func errorSignalsWith(_ code:Int) ->Signal<NSError, NoError> {
        return self.errorSignal.filter({ (error) -> Bool in
            return error.code == code
        })
    }
}

extension SGTMVVMViewModel: SGTMVVMModelToViewRelationProtocol {
    open func viewClass() -> AnyClass {
        return SGTMVVMView.self
    }
    open func viewClassName() ->String{
        return "SGTMVVMView"
    }
    open func viewClassSpec() -> String {
        return "SGTMVVMView"
    }
    open func nibExist() -> Bool {
        return Bundle.main.path(forResource: viewClassName(), ofType: "nib") != nil
    }
}
