//
//  SGTMVVMView.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/21.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit

open class SGTMVVMView: UIView, SGTMVVMViewProtocol {
    public var vm: SGTMVVMViewModelProtocol
    required public init(viewModel: SGTMVVMViewModelProtocol) {
        self.vm = viewModel
        super.init(frame: CGRect.zero)
        bind(viewModel)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(_ viewModel: SGTMVVMViewModelProtocol) {
        
    }
    public func unBind(_ viewModel: SGTMVVMViewModelProtocol) {
        
    }
    
    public func viewType() -> SGTMVVMViewType {
        return .normalView
    }
    
    public func getReactView() -> UIView? {
        return self
    }
}
