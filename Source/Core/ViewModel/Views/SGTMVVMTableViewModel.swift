//
//  SGTMVVMTableViewModel.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/16.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit
import ReactiveSwift

public struct SGTMVVMTableFetchConfig {
    
    var index: Int
    
    var params: [String:Any]
    
    public static func emptyConfig() -> SGTMVVMTableFetchConfig {
        return SGTMVVMTableFetchConfig(index: 0, params: Dictionary())
    }
}

open class SGTMVVMTableViewModel: SGTMVVMViewModel {
    
    /// config use to load remote or local data
    open var dataFechConfig: SGTMVVMTableFetchConfig = SGTMVVMTableFetchConfig.emptyConfig()
    
    /// tableview datasource to present
    open var dataSource: SGTMVVMTableDataSource = SGTMVVMTableDataSource()
    
    /// should pull refresh used
    open var pullRefreshEnable: MutableProperty<Bool> = MutableProperty<Bool>(false)
    
    /// should pull load more used
    open var pullLoadMoreEnable: MutableProperty<Bool> = MutableProperty<Bool>(false)
    
    /// define the table view style. default was .grouped
    public var tableViewStyle: UITableViewStyle = .grouped
    
    /// action when the pull refresh action was triggled
    public var pullRefreshDataCommand: Action<SGTMVVMTableFetchConfig,AnyObject,NSError>?
    
    /// action when the pull to load more action was triggled
    public var loadMoreDataCommand: Action<SGTMVVMTableFetchConfig,AnyObject,NSError>?
    
    /// action when the load local action was triggled
    public var loadLocalDataCommand: Action<SGTMVVMTableFetchConfig,AnyObject,NSError>?
    
    /// is tableviewmodel on pull refresh state
    public var isPullRefresh: MutableProperty<Bool> = MutableProperty<Bool>(false)
    
    /// is tableviewmodel on load more state
    public var isLoadMore: MutableProperty<Bool> = MutableProperty<Bool>(false)
    
    /// when the datasource was changed, change the table view use animate or not
    public var updataTableAnimated: Bool = false
    
    /// when the datasource has some data inserted or appended, change the table view use animate or not
    public var insertTableAnimated: Bool = false
    
    /// when the datasource has some data delete, change the table view use animate or not
    public var deleteTableAnimated: Bool = false
    
    /// animate style when table datasource has some data inserted
    public var insertAnimate: UITableViewRowAnimation = .automatic
    
    /// animate style when table datasource has one data deleted
    public var deleteAnimate: UITableViewRowAnimation = .left
    
    /// animate style when table datasource has one data updated
    public var updateAnimate: UITableViewRowAnimation = .automatic
    
    /// thread safe queue
    internal var dataSourceChangeQueue = DispatchQueue(label: "SGTMVVMTableViewModel")
    
    open override func viewClass() -> AnyClass {
        return SGTMVVMTableView.self
    }
    
    /// updata the datasource thread safe
    ///
    /// - Parameter inhandle: updata action clouser
    public func inDataQueue(_ inhandle: @escaping ((_ dataSource:SGTMVVMTableDataSource) -> Void )) {
        dataSourceChangeQueue.sync {[unowned self] in
            inhandle(self.dataSource)
        }
    }
    
}
