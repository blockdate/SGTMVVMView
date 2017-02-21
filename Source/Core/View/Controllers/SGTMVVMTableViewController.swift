//
//  SGTMVVMTableViewController.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/16.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import MJRefresh_S
import DZNEmptyDataSet
import SnapKit

open class SGTMVVMTableViewController: SGTMVVMViewController {
    
    public var tableView: SGTMVVMTableView
    
    public var tableFetchConfig: SGTMVVMTableFetchConfig = SGTMVVMTableFetchConfig.emptyConfig()
    
    open var viewModel: SGTMVVMTableControllerViewModel {return self.vm as! SGTMVVMTableControllerViewModel}
    
    required public init(viewModel: SGTMVVMViewModelProtocol) {
        guard let tableViewModel = viewModel as? SGTMVVMTableControllerViewModel else {
            fatalError("init SGTMVVMTableViewController error with viewmodel:\(viewModel), expect a SGTMVVMTableControllerViewModel")
        }
        self.tableView = SGTMVVMTableView(viewModel: tableViewModel.tableViewModel)
        super.init(viewModel: viewModel)
        self.reactive.trigger(for: #selector(SGTMVVMTableViewController.viewDidLoad)).observeValues { [weak self] in
            guard let controller = self else {
                return
            }
            // load the local data if needed
            if controller.viewModel.presentLocalDataBeforeRemoteData {
                controller.viewModel.loadLocalDataCommand?.consume(controller.tableFetchConfig)
            }
            // load remote data if need
            if controller.viewModel.loadRemoteDataOnViewLoad {
                if controller.viewModel.pullRefreshEnable.value {
                    // using the tableview pull refresh action to load
                    controller.tableView.mj_header?.beginRefreshing()
                    controller.tableView.reloadEmptyDataSet()
                }else {
                    // load tableview data with no tableview animate
                    let cmd = controller.viewModel.pullRefreshDataCommand ?? controller.viewModel.loadMoreDataCommand
                    let _ = cmd?.consume(controller.tableFetchConfig)
                }
            }
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("SGTMVVMTableViewController init with adecoder was not correct, change to use init(viewModel:) instead")
    }
    
}

extension SGTMVVMTableViewController {
    override func initializeView() {
        super.initializeView()
        self.initialiseTableView()
        self.initialiseCustomView()
        self.layOutTableView()
    }
    
    open func initialiseCustomView(){}
    
    /**
     初始化tableview
     注册所需nib   cellNibForTableView
     注册所需class cellClassForTableView
     按需添加刷新组件
     */
    open func initialiseTableView() {
        self.view.addSubview(tableView)
    }
    
    /**
     布局tableview，如需修改tableview布局请override 或者 snp.remakeConstraints
     */
    open func layOutTableView() {
        if let view = self.tableView.superview {
            self.tableView.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(view)
            }
        }
    }
    
}
