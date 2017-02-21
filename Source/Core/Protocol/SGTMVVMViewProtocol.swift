//
//  SGTMVVMViewProtocol.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/15.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit

public enum SGTMVVMViewType {
    case normalView
    case controller
    case tableViewCell
}

public protocol SGTMVVMViewBindingProtocol: class {
    
    var vm: SGTMVVMViewModelProtocol{get}
    
    func bind(_ viewModel: SGTMVVMViewModelProtocol)
    
    func unBind(_ viewModel: SGTMVVMViewModelProtocol)
    
}

public protocol SGTMVVMReuseViewBindingProtocol: class {
    
    weak var vm: SGTMVVMReuseViewModelProtocol? {get}
    
    func bind(_ viewModel: SGTMVVMReuseViewModelProtocol)
    
    func unBind(_ viewModel: SGTMVVMReuseViewModelProtocol)
    
}

public protocol SGTMVVMViewProtocol: SGTMVVMViewBindingProtocol{
    
    init(viewModel: SGTMVVMViewModelProtocol)
    
    func viewType() -> SGTMVVMViewType
    
    func getReactView() -> UIView?
    
}

public protocol SGTMVVMTableViewCellProtocol: SGTMVVMReuseViewBindingProtocol {
    
}

public protocol SGTMVVMReuseViewProtocol: SGTMVVMReuseViewBindingProtocol {
    
}
