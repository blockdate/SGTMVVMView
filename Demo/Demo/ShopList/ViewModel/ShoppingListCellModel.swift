//
//  ShoppingListCellModel.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/14.
//  Copyright © 2017年 wleo block. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class ShoppingListCellModel: SGTMVVMSwipeTableCellViewModel {
    
    dynamic var title: String { return self.shoppingItem.name }
    dynamic var price: String = ""
    dynamic var count: String = ""
    
    override func viewClassName() -> String {
        return "ShoppingListViewCell"
    }
    
    var shoppingItem: ShoppingItem
    
    var deleteTitleConfig: SGTSwipeButtonTitleConfig?
    var archiveTitleConfig: SGTSwipeButtonTitleConfig?
    var modifyTitleConfig: SGTSwipeButtonTitleConfig?
    
    var deleteCommand: CocoaAction<IndexPath>? {didSet{deleteTitleConfig?.command = deleteCommand}}
    var modifyCommand: CocoaAction<IndexPath>? {didSet{modifyTitleConfig?.command = modifyCommand}}
    var archiveCommand: CocoaAction<IndexPath>? {didSet{archiveTitleConfig?.command = archiveCommand}}
    
    init(service: SGTMVVMPageRouteServicesProtocol, _ shoppingItem: ShoppingItem) {
        self.shoppingItem = shoppingItem
        super.init(service: service)
    }
    
    override func initialize() {
        super.initialize()
//        RACObserve(self.shoppingItem, keyPath: "count").map{"\($0!)"} ~> SGTRAC(self, "count", "1")
//        Signal.combineLatest([Property(value:)]).map { in
//            let price = $0.0
//            let count = $0.1
//            return "100";
//        }
//        RACSignal.combineLatest([RACObserve(self.shoppingItem, keyPath: "price"), RACObserve(self.shoppingItem, keyPath: "count")] as NSArray).map {
//            let tuple = $0 as! RACTuple
//            let price = tuple.first
//            let count = tuple.second
//            DDLogDebug("price: \(price), count: \(count)")
//            return "100";
//        } ~> SGTRAC(self,"price", "0.00")
        
        deleteCommand = nil
        modifyCommand = nil
        archiveCommand = nil
        
        deleteTitleConfig = SGTSwipeButtonTitleConfig(title: "Trash", backColor: UIColor.red, image: nil, command: deleteCommand)
        modifyTitleConfig = SGTSwipeButtonTitleConfig(title: "Modify", backColor: UIColor.orange, image: nil, command: modifyCommand)
        archiveTitleConfig = SGTSwipeButtonTitleConfig(title: "Archive", backColor: UIColor.blue, image: nil, command: archiveCommand)
        
        self.leftSwipeTitles = [archiveTitleConfig!]
        self.rightSwipeTitles = [deleteTitleConfig!, modifyTitleConfig!]
        
    }
    
    override func rowHeight() -> CGFloat {
        return 80
    }
}
