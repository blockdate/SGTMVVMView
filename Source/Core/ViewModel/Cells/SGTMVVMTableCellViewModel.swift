//
//  SGTMVVMTableCellViewModel.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/16.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import enum Result.NoError

open class SGTMVVMTableCellViewModel: NSObject, SGTMVVMReuseViewModelProtocol {
    open var frame: CGRect = CGRect.zero
    open var padding: UIEdgeInsets = UIEdgeInsets.zero
    
    public var (errorSignal, errorObserver) = Signal<NSError,NoError>.pipe()
    
    public var (executingSignal, executingObserver) = Signal<Bool, NoError>.pipe()
    
    open fileprivate(set) var pageRouteService: SGTMVVMPageRouteServicesProtocol = SGTMVVMInject.inject()
    
    open var indexPath: IndexPath?
    open var selectedCommand: CocoaAction<IndexPath>?
    open var identify: String {return "\(self.viewClass())"}
    open var size: CGSize = CGSize.zero
    
    public func viewClass() -> AnyClass {
        return SGTMVVMTableViewCell.self
    }
    public func viewClassName() ->String{
        return "SGTMVVMTableViewCell"
    }
    public func viewClassSpec() -> String {
        return "SGTMVVMTableViewCell"
    }
    
    override public init() {
        super.init()
        self.initialize()
    }
    
    public init(service: SGTMVVMPageRouteServicesProtocol) {
        self.pageRouteService = service
        super.init()
        initialize()
    }
    
    //
    open func initialize(){
        self.size = CGSize(width: SGTUtilScreenSize.screenWidth, height: 44)
    }
    
    open func setupData() {}
    
    //
    public private(set) var rowHeightProperty: MutableProperty<CGFloat> = MutableProperty<CGFloat>(44.0)
    /**
     提供当前cell对应的高度
     
     - returns: height
     */
    open func rowHeight() ->CGFloat {
        return self.size.height
    }
    
    open func updateRowHeight(_ h:CGFloat) {
        if self.size.height == h {
            return
        }
        self.size.height = h
        self.rowHeightProperty.consume(h)
    }
    
    open func nibExist() ->Bool {
        return Bundle.main.path(forResource: viewClassName(), ofType: "nib") != nil
    }
    
    deinit {
        SGTLogDebug("deinit")
    }
    
}
