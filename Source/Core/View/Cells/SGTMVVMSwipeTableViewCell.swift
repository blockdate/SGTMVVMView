//
//  SGTMVVMSwipeTableViewCell.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/16.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit
import MGSwipeTableCell
import ReactiveSwift
import ReactiveCocoa
import enum Result.NoError

class SGTMVVMSwipeTableViewCell: MGSwipeTableCell, SGTMVVMTableViewCellProtocol {
    
    weak var vm: SGTMVVMReuseViewModelProtocol?
    
    public var (updateNeedSignal, updateNeedObserver) = Signal<UITableViewCell, NoError>.pipe()
    
    open var prepareForReuseSignal: Signal<(),NoError> {
        return Signal.merge([self.reactive.prepareForReuse, self.reactive.trigger(for: #selector(SGTMVVMTableViewCell.bindViewModel(_:)))])
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialise()
    }
    
    required override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialise()
    }
    func initialise() {
//        RACObserve(self, keyPath: "vm")
//            .filter({ (obj) -> Bool in
//                return obj != nil && (obj as? SGTMVVMReuseViewModelProtocol) != nil
//            })
//            .subscribeNext {[weak self] (obj) -> Void in
//                self?.bind(obj as! SGTMVVMReuseViewModelProtocol)
//        }
        
        //        self.contentView.addSubview(lineView)
        //        lineView.drawLine = true
        //        lineView.isLayonTop = false
        //        lineView.snp.makeConstraints { (make) -> Void in
        //            let _ = make.left.right.bottom.equalTo(self)
        //            let _ = make.height.equalTo(1)
        //        }
        self.selectionStyle = .none
    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    open func bind(_ viewModel: SGTMVVMReuseViewModelProtocol) {
        if viewModel is SGTMVVMSwipeTableCellViewModel {
            bindViewModel(viewModel as! SGTMVVMSwipeTableCellViewModel)
        }
    }
    
    func unBind(_ viewModel: SGTMVVMReuseViewModelProtocol) {
        
    }
    
    public func bindViewModel(_ viewmodel: SGTMVVMSwipeTableCellViewModel) {
        viewmodel.rowHeightProperty.signal.skip(first: 1).take(until: self.prepareForReuseSignal).observeValues {[weak self] (height) in
            guard let cell = self else {
                return
            }
            cell.updateNeedObserver.send(value: cell)
        }
        
        self.delegate = viewmodel
    }

}
