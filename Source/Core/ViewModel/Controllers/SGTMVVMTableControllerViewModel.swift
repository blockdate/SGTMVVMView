//
//  SGTMVVMTableControllerViewModel.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/17.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit
import ReactiveSwift

open class SGTMVVMTableControllerViewModel: SGTMVVMControllerViewModel {
    
    var tableViewModel: SGTMVVMTableViewModel
    /// tableview datasource to present
    public var dataSource: SGTMVVMTableDataSource {return tableViewModel.dataSource}
    
    /// load remote data on view loadded
    public var loadRemoteDataOnViewLoad: Bool = true
    
    /// load local data to present before the remote data was loaded
    public var presentLocalDataBeforeRemoteData: Bool = false
    
    /// should pull refresh used
    public var pullRefreshEnable: MutableProperty<Bool> {get{return tableViewModel.pullRefreshEnable}}
    
    /// should pull load more used
    public var pullLoadMoreEnable: MutableProperty<Bool> {get{return tableViewModel.pullLoadMoreEnable}}
    
    /// define the table view style. default was .grouped
    public var tableViewStyle: UITableViewStyle {get{return tableViewModel.tableViewStyle} set{tableViewModel.tableViewStyle = newValue}}
    
    /// action when the pull refresh action was triggled
    public var pullRefreshDataCommand: Action<SGTMVVMTableFetchConfig,AnyObject,NSError>? {get{return tableViewModel.pullRefreshDataCommand} set{tableViewModel.pullRefreshDataCommand = newValue}}
    
    /// action when the pull to load more action was triggled
    public var loadMoreDataCommand: Action<SGTMVVMTableFetchConfig,AnyObject,NSError>? {get{return tableViewModel.loadMoreDataCommand} set{tableViewModel.loadMoreDataCommand = newValue}}
    
    /// action when the load local action was triggled
    public var loadLocalDataCommand: Action<SGTMVVMTableFetchConfig,AnyObject,NSError>? {get{return tableViewModel.loadLocalDataCommand} set{tableViewModel.loadLocalDataCommand = newValue}}
    
    /// when the datasource was changed, change the table view use animate or not
    public var updataTableAnimated: Bool {get{return tableViewModel.updataTableAnimated} set{tableViewModel.updataTableAnimated = newValue}}
    
    /// when the datasource has some data inserted or appended, change the table view use animate or not
    public var insertTableAnimated: Bool {get{return tableViewModel.insertTableAnimated} set{tableViewModel.insertTableAnimated = newValue}}
    
    /// when the datasource has some data delete, change the table view use animate or not
    public var deleteTableAnimated: Bool {get{return tableViewModel.deleteTableAnimated} set{tableViewModel.deleteTableAnimated = newValue}}
    
    /// animate style when table datasource has some data inserted
    public var insertAnimate: UITableViewRowAnimation {get{return tableViewModel.insertAnimate} set{tableViewModel.insertAnimate = newValue}}
    
    /// animate style when table datasource has one data deleted
    public var deleteAnimate: UITableViewRowAnimation {get{return tableViewModel.deleteAnimate} set{tableViewModel.deleteAnimate = newValue}}
    
    /// animate style when table datasource has one data updated
    public var updateAnimate: UITableViewRowAnimation {get{return tableViewModel.updateAnimate} set{tableViewModel.updateAnimate = newValue}}
    
    required public init(service: SGTMVVMPageRouteServicesProtocol) {
        tableViewModel = SGTMVVMTableViewModel(service: service)
        super.init(service: service)
    }
    
    open override func viewClass() -> AnyClass {
        return SGTMVVMTableViewController.self
    }
    
    required public init() {
        tableViewModel = SGTMVVMTableViewModel()
        super.init()
    }
    
    /// updata the datasource thread safe
    ///
    /// - Parameter inhandle: updata action clouser
    public func inDataQueue(_ inhandle: @escaping ((_ dataSource:SGTMVVMTableDataSource) -> Void )) {
        tableViewModel.dataSourceChangeQueue.sync {[weak self] in
            guard let vm = self else {
                return
            }
            inhandle(vm.tableViewModel.dataSource)
        }
    }
    
}
