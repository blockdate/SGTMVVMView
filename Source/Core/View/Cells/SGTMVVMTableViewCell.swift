//
//  SGTMVVMTableViewCell.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/16.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import enum Result.NoError

open class SGTMVVMTableViewCell: UITableViewCell, SGTMVVMTableViewCellProtocol {
    
    weak public var vm: SGTMVVMReuseViewModelProtocol?
    
    public var (updateNeedSignal, updateNeedObserver) = Signal<UITableViewCell, NoError>.pipe()
    
    open var prepareForReuseSignal: Signal<(),NoError> {
        return Signal.merge([self.reactive.prepareForReuse, self.reactive.trigger(for: #selector(SGTMVVMTableViewCell.bindViewModel(_:)))])
    }
    
    required override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    open func initialize() {
        
    }
    
    open func bind(_ viewModel: SGTMVVMReuseViewModelProtocol) {
        if viewModel is SGTMVVMTableCellViewModel {
            bindViewModel(viewModel as! SGTMVVMTableCellViewModel)
        }
    }
    
    public func bindViewModel(_ viewmodel: SGTMVVMTableCellViewModel) {
        
    }
    
    open func unBind(_ viewModel: SGTMVVMReuseViewModelProtocol) {
        
    }
}
