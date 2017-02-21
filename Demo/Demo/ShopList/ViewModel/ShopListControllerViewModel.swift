//
//  ShopListControllerViewModel.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/14.
//  Copyright © 2017年 wleo block. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import enum Result.NoError

class ShopListControllerViewModel: SGTMVVMTableControllerViewModel {
    
    var addShoppingItemCommand: CocoaAction<ShoppingItem>?
    
    var deleteShoppinItemCommand: CocoaAction<IndexPath>?
    
    var modifyShoppinItemCommand: CocoaAction<IndexPath>?
    
    var archiveShoppinItemCommand: CocoaAction<IndexPath>?
    
    var cellSelectCommand: CocoaAction<IndexPath>?
    
    override func initialize() {
        super.initialize()
        self.setupCommands()
        self.fakeNewData()
        self.pullLoadMoreEnable.consume(true)
        self.pullRefreshEnable.consume(true)
        self.insertAnimate = .automatic
    }
    
    func setupCommands() {
        let deleteAction = Action<IndexPath, Bool, NSError> { (index) -> SignalProducer<Bool, NSError> in
            self.dataSource[index.section]?.remove(index.row)
            return SignalProducer.empty
        }
        deleteShoppinItemCommand = CocoaAction(deleteAction, { $0 })
        cellSelectCommand = CocoaAction(Action({[weak self] (indexPath) -> SignalProducer<Bool, NSError> in
            guard let viewmodel = self else {return SignalProducer.empty}
            viewmodel.junpToNewController()
            return SignalProducer.empty
        }), { $0 })
        self.pullRefreshDataCommand = Action({[weak self] (config) -> SignalProducer<AnyObject, NSError> in
            return SignalProducer({ (observer, disposable) in
                self?.fakeNewData()
                observer.sendCompleted()
            })
        })
        self.loadMoreDataCommand = Action({[weak self] (config) -> SignalProducer<AnyObject, NSError> in
            return SignalProducer({ (observer, disposable) in
                self?.fakeOldData()
                observer.sendCompleted()
            })
        })
    }
    
    func junpToNewController() {
        let newVCM = SGTMVVMControllerViewModel()
        self.pageRouteService.pushViewModel(newVCM, animated: true)
    }
}

extension ShopListControllerViewModel {
    func fakeNewData() {
        let items = self.fakeDataList()
        var cells :Array<ShoppingListCellModel> = Array()
        for item in items {
            let cellVM = ShoppingListCellModel(service: self.pageRouteService, item);
            cellVM.modifyCommand = self.modifyShoppinItemCommand
            cellVM.archiveCommand = self.archiveShoppinItemCommand
            cellVM.deleteCommand = self.deleteShoppinItemCommand
            cellVM.selectedCommand = self.cellSelectCommand
            cells.append(cellVM)
        }
        self.dataSource.removeAll()
        self.dataSource.append(cells)
    }
    func fakeOldData() {
        let items = self.fakeDataList()
        var cells :Array<ShoppingListCellModel> = Array()
        for item in items {
            let cellVM = ShoppingListCellModel(service: self.pageRouteService, item);
            cellVM.modifyCommand = self.modifyShoppinItemCommand
            cellVM.archiveCommand = self.archiveShoppinItemCommand
            cellVM.deleteCommand = self.deleteShoppinItemCommand
            cellVM.selectedCommand = self.cellSelectCommand
            cells.append(cellVM)
        }
        self.dataSource.append(cells, atIndex: 0)
    }
    func fakeDataList() -> Array<ShoppingItem> {
        var resultArr = Array<ShoppingItem>()
        for i in 0...10 {
            let item = ShoppingItem(name: "product: \(i)")
            resultArr.append(item)
        }
        return resultArr
    }
}
