//
//  SGTViewModelProtocol.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/15.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit
import ReactiveSwift
import enum Result.NoError

public protocol SGTMVVMModelToViewRelationProtocol: class {
    func viewClass() -> AnyClass
    func viewClassName() -> String
    func viewClassSpec() -> String
    func nibExist() -> Bool
}

public protocol SGTMVVMViewModelProtocol: SGTMVVMModelToViewRelationProtocol {
    
    /// those used to create a custom by a viewmodel
    /// define the frame of the view
    var frame: CGRect {get set}
    
    /// define the padding frame of the view
    var padding: UIEdgeInsets {get set}
    
    /// signal that send the error happed on the view model
    var errorSignal: Signal<NSError, NoError> {get set}
    
    /// is the view model execute some thing need to use the loading animate
    var executingSignal: Signal<Bool, NoError> {get set}
    
    var pageRouteService: SGTMVVMPageRouteServicesProtocol{get}
    
}

public protocol SGTMVVMReuseViewModelProtocol: SGTMVVMViewModelProtocol {
    var identify: String {get}
    var size: CGSize {get set}
    var indexPath: IndexPath? {get set}
}

public protocol SGTMVVMCollectionCellViewModelProtocol: SGTMVVMReuseViewModelProtocol {
    
}

public protocol SGTMVVMTableHeaderViewModelProtocol: SGTMVVMReuseViewModelProtocol {
    
}

public protocol SGTMVVMURLOpenableViewModelProtocol {
    init(service:SGTMVVMPageRouteServicesProtocol, param:Dictionary<String,Any>?)
    static func avaliableForParam(_ param:Dictionary<String,Any>?) -> Bool
}
