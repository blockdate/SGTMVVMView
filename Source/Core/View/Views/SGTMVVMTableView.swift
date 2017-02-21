//
//  SGTMVVMTableView.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/16.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import ReactiveSwift
import ReactiveCocoa
import MJRefresh_S

open class SGTMVVMTableView: UITableView, SGTMVVMViewProtocol {
    
    public var vm: SGTMVVMViewModelProtocol
    
    open var viewModel: SGTMVVMTableViewModel {return vm as! SGTMVVMTableViewModel}
    
    required public init(viewModel: SGTMVVMViewModelProtocol) {
        vm = viewModel
        super.init(frame: CGRect.zero, style: .grouped)
        self.initialize()
        self.bind(viewModel)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func initialize() {
        self.dataSource = self
        self.delegate = self
        self.emptyDataSetSource = self
        self.emptyDataSetDelegate = self
        self.backgroundColor = UIColor.white
    }
    
    public func viewType() -> SGTMVVMViewType {
        return .normalView
    }
    
    public func getReactView() -> UIView? {
        return self
    }
    
    public func bind(_ viewModel: SGTMVVMViewModelProtocol) {
        self.bindDataSource()
        self.observeFreshData()
    }
    
    public func unBind(_ viewModel: SGTMVVMViewModelProtocol) {
        
    }
    
    open func bindDataSource() {
        //when single row data changed or some row data chaned
        self.viewModel.dataSource.rowDataChangeSignal.observeValues {[weak self] (indexPathStatus) in
            guard let tableView = self else {return}
            switch indexPathStatus.changeType {
            case .insertion:
                tableView.viewModel.insertTableAnimated ? tableView.insertRows(at: indexPathStatus.changeIndexes, with: tableView.viewModel.insertAnimate) : tableView.insertRows(at: indexPathStatus.changeIndexes, with: UITableViewRowAnimation.none)
                break;
            case .removal:
                tableView.viewModel.deleteTableAnimated ? tableView.deleteRows(at: indexPathStatus.changeIndexes, with: tableView.viewModel.deleteAnimate) : tableView.deleteRows(at: indexPathStatus.changeIndexes, with: .none)
                break;
            case .replacement:
                tableView.viewModel.updataTableAnimated ? tableView.reloadRows(at: indexPathStatus.changeIndexes, with: tableView.viewModel.updateAnimate) : tableView.reloadRows(at: indexPathStatus.changeIndexes, with: .none)
                break;
            default:
                tableView.reloadData()
            }
        }
        
        //when single section data changed or some section data chaned
        self.viewModel.dataSource.sectionDataChangeSignal.observeValues {[weak self] (indexStatus) in
            guard let tableView = self else {return}
            switch indexStatus.changeType {
            case .insertion:
                tableView.viewModel.insertTableAnimated ? tableView.insertSections(IndexSet(indexStatus.changeIndexes), with: tableView.viewModel.insertAnimate) : tableView.insertSections(IndexSet(indexStatus.changeIndexes), with: .none)
                break;
            case .removal:
                tableView.viewModel.deleteTableAnimated ? tableView.deleteSections(IndexSet(indexStatus.changeIndexes), with: tableView.viewModel.insertAnimate) : tableView.deleteSections(IndexSet(indexStatus.changeIndexes), with: .none)
                break;
            case .replacement:
                tableView.viewModel.updataTableAnimated ? tableView.reloadSections(IndexSet(indexStatus.changeIndexes), with: tableView.viewModel.insertAnimate) : tableView.reloadSections(IndexSet(indexStatus.changeIndexes), with: .none)
                break;
            default:
                tableView.reloadData()
            }
        }
    }
    
    open func observeFreshData() {
        
        self.viewModel.pullRefreshEnable.producer.startWithSignal {[weak self] (signal, dispose) in
            signal.observeValues({ (enable) in
                self?.enablePullRefresh(enable: enable)
            })
        }
        self.viewModel.pullLoadMoreEnable.producer.startWithSignal {[weak self] (signal, dispose) in
            signal.observeValues({ (enable) in
                self?.enableLoadMore(enable: enable)
            })
        }
        if self.viewModel.pullRefreshDataCommand != nil {
            self.viewModel.isPullRefresh <~ self.viewModel.pullRefreshDataCommand!.isExecuting
        }
        if self.viewModel.loadMoreDataCommand != nil {
            self.viewModel.isLoadMore <~ self.viewModel.loadMoreDataCommand!.isExecuting
        }
        
        self.viewModel.isPullRefresh.signal.observeValues {[weak self] (shouldPullRefresh) in
            DDLogDebug("\(shouldPullRefresh ? "should start" : "should end") refresh")
            guard let mj_header = self?.mj_header else {return}
            if shouldPullRefresh {
                if !mj_header.isRefreshing() {
                    mj_header.beginRefreshingWithoutCallBack()
                }
            }else {
                if mj_header.isRefreshing() {
                    mj_header.endRefreshing()
                    DDLogDebug("end refresh")
                }
            }
        }
        
        self.viewModel.isLoadMore.signal.observeValues {[weak self] (shouldLoadMore) in
            DDLogDebug("\(shouldLoadMore ? "should start" : "should end") loadmore")
            guard let mj_footer = self?.mj_footer else {return}
            if shouldLoadMore {
                if !mj_footer.isRefreshing() {
                    mj_footer.beginRefreshing()
                }
            }else {
                if mj_footer.isRefreshing() {
                    mj_footer.endRefreshing()
                }
            }
        }
        
        
    }
    
    open func enablePullRefresh(enable: Bool) {
        if enable {
            DDLogDebug("enable pull load more")
            self.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(SGTMVVMTableView.pullRefresh))
        }else {
            DDLogDebug("disable pull load more")
        }
    }
    
    open func enableLoadMore(enable: Bool) {
        if enable {
            DDLogDebug("enable pull refresh")
            self.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(SGTMVVMTableView.pullLoadMore))
        }else {
            DDLogDebug("disable pull refresh")
        }
    }
    
    open func pullRefresh() {
        self.viewModel.pullRefreshDataCommand?.consume(self.viewModel.dataFechConfig)
    }
    
    open func pullLoadMore() {
        self.viewModel.loadMoreDataCommand?.consume(self.viewModel.dataFechConfig)
    }
    
}

extension SGTMVVMTableView: UITableViewDelegate, UITableViewDataSource{
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.dataSource.sectionCount()
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataSource[section]?.count ?? 0
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        var height: CGFloat = 10
        
        if let header = viewModel.dataSource[section]?.header {
            return header.value.frame.height
        }
        
        if self.viewModel.dataSource.sectionCount() == 1 {
            height = 0
        }
        
        if section == 0 {
            height = 0
        }
        
        if let header = viewModel.dataSource[section]?.header {
            height = header.value.frame.size.height
        }
        
        return height
        
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var height: CGFloat = 0.1
        
        if self.viewModel.dataSource.sectionCount() == 1 {
            height = 0
        }
        if section == 0 {
            height = 0
        }
        if let footer = viewModel.dataSource[section]?.footer {
            height = footer.value.frame.size.height
        }
        return height
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view: UIView?
        if let header = viewModel.dataSource[section]?.header?.value {
            view = SGTMVVMPageRouter.viewForViewModel(header)
            view?.frame = CGRect(x: 0, y: 0, width: SGTUtilScreenSize.screenWidth, height: self.tableView(tableView, heightForHeaderInSection: section))
        }else {
            let frame = CGRect(x: 0, y: 0, width: SGTUtilScreenSize.screenWidth, height: self.tableView(tableView, heightForHeaderInSection: section))
            let view = UIView(frame: frame)
            view.backgroundColor = SGTColor.background
        }
        return view
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.dataSource[indexPath.section]?[indexPath.row]?.rowHeight() ?? 0
    }
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let c: SGTMVVMTableViewCellProtocol = cell as? SGTMVVMTableViewCellProtocol {
            guard let cellModel = self.viewModel.dataSource[(indexPath as NSIndexPath).section]?[(indexPath as NSIndexPath).row] else {
                
                fatalError("get cell model empty on (SGTMVVMTableView.tableView(_:willDisplay:forRowAt:), indexPath \(indexPath.section):\(indexPath.row)")
            }
            cellModel.indexPath = indexPath
            if let cell = c as? SGTMVVMTableViewCell {
                //                cell.delegate = self
                cell.bind(cellModel)
            } else if let cell = c as? SGTMVVMSwipeTableViewCell {
                cell.bind(cellModel)
            }
        }else {
            SGTLogError("cell 未实现 SGTMVVMReuseViewModelProtocol ")
        }
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = self.viewModel.dataSource[(indexPath as NSIndexPath).section]?[(indexPath as NSIndexPath).row] else {
            fatalError("get cell model empty on tableview tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath), indexPath \(indexPath.section):\(indexPath.row)")
        }
        
        cellModel.indexPath = indexPath
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identify)
        
        if cell != nil {
            return cell!
        }
        
        if let vcsa: SGTMVVMTableViewCell.Type = cellModel.viewClass() as? SGTMVVMTableViewCell.Type {
            let c = normalSGTCellForIndexPath(indexPath, vcsa: vcsa)
            return c
        }else if let vcsa: SGTMVVMSwipeTableViewCell.Type = cellModel.viewClass() as? SGTMVVMSwipeTableViewCell.Type {
            let c = swipeSGTCellForIndexPath(indexPath, vcsa: vcsa)
            return c
        }else {
            SGTLogError("cell \(cellModel.identify)  was not find")
            return UITableViewCell(style: .default, reuseIdentifier: "errorCell")
        }

    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewModel = viewModel.dataSource[indexPath.section]?[indexPath.row] {
            viewModel.selectedCommand?.execute(indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    fileprivate func relaodCell(cell: UITableViewCell) {
        if let indexPath = self.indexPath(for: cell) {
            self.reloadRows(at: [indexPath], with: .none)
        }else {
            DDLogError("cell should reload but indexPath was not founded, cell:\(cell)")
        }
    }
    
    fileprivate func normalSGTCellForIndexPath(_ indexPath:IndexPath,vcsa: SGTMVVMTableViewCell.Type) -> SGTMVVMTableViewCell{
        guard let cellModel = self.viewModel.dataSource[(indexPath as NSIndexPath).section]?[(indexPath as NSIndexPath).row] else {
            fatalError("get cell model empty on tableview normalSGTCellForIndexPath, indexPath \(indexPath.section):\(indexPath.row)")
        }
        if Bundle.main.path(forResource: cellModel.viewClassName(), ofType: "nib") != nil {
            let nibs = Bundle.main.loadNibNamed(cellModel.viewClassName(), owner: nil, options: nil)
            if !emptyOrNilArray(nibs as AnyObject?) {
                if let cell = nibs?.first as? SGTMVVMTableViewCell {
                    cell.updateNeedSignal.observeValues({[weak self] (cell) in
                        self?.relaodCell(cell: cell)
                    })
                    return cell
                }else {
                    SGTLogWarn("cell \(cellModel.identify)  was not a SGTTableViewCell Type or MGSwipeTableCell")
                    return SGTMVVMTableViewCell(style: .default, reuseIdentifier: "errorCell")
                }
            }else {
                SGTLogError("cell \(cellModel.identify)  init error")
                return SGTMVVMTableViewCell(style: .default, reuseIdentifier: "errorCell")
            }
        }else {
            
            let cell = vcsa.init(style: .default, reuseIdentifier: cellModel.identify)
            cell.updateNeedSignal.observeValues({[weak self] (cell) in
                self?.relaodCell(cell: cell)
            })
            return cell
        }
    }
    
    fileprivate func swipeSGTCellForIndexPath(_ indexPath:IndexPath,vcsa: SGTMVVMSwipeTableViewCell.Type) -> SGTMVVMSwipeTableViewCell{
        guard let cellModel = self.viewModel.dataSource[(indexPath as NSIndexPath).section]?[(indexPath as NSIndexPath).row] else {
            fatalError("get cell model empty on tableview swipeSGTCellForIndexPath, indexPath \(indexPath.section):\(indexPath.row)")
        }
        if Bundle.main.path(forResource: cellModel.viewClassName(), ofType: "nib") != nil {
            let nibs = Bundle.main.loadNibNamed(cellModel.viewClassName(), owner: nil, options: nil)
            if !emptyOrNilArray(nibs as AnyObject?) {
                if let cell = nibs?.first as? SGTMVVMSwipeTableViewCell {
                    return cell
                }else {
                    SGTLogError("cell \(cellModel.identify)  init error")
                    return SGTMVVMSwipeTableViewCell(style: .default, reuseIdentifier: "errorCell")
                }
            }else {
                SGTLogError("cell \(cellModel.identify)  init error")
                return SGTMVVMSwipeTableViewCell(style: .default, reuseIdentifier: "errorCell")
            }
        }else {
            let cell = vcsa.init(style: .default, reuseIdentifier: cellModel.identify)
            return cell
        }
    }
}

extension SGTMVVMTableView: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
}
