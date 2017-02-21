//
//  SGTMVVMTableDataGroup.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/16.
//  Copyright © 2017年 sgt. All rights reserved.
//

import Foundation
import ReactiveSwift
import UIKit
import enum Result.NoError

public struct SGTMVVMTableDataChanedStatus<T> {
    var changeType: NSKeyValueChange
    var changeIndexes: Array<T>
    
    init(type: NSKeyValueChange, changeIndexes: Array<T>) {
        self.changeType = type
        self.changeIndexes = changeIndexes
    }
    
}

open class SGTMVVMTableDataSection: NSObject {
    
    var sectionIndex: Int = 0
    var datas: Array<SGTMVVMTableCellViewModel> = Array()
    
    var header: MutableProperty<SGTMVVMViewModel>?
    var footer: MutableProperty<SGTMVVMViewModel>?
    
    fileprivate var _iteratorCount: Int = -1
    
    public fileprivate(set) var (dataChangeSignal, dataChangeObserver) = Signal<SGTMVVMTableDataChanedStatus<IndexPath>, NoError>.pipe()
    
    public init(datas: Array<SGTMVVMTableCellViewModel>) {
        super.init()
        initialize()
        self.datas.append(contentsOf: datas)
    }
    
    fileprivate func initialize() {
    }
    
    var section: Int {
        return self.sectionIndex
    }
    
    var count: Int {
        return self.datas.count
    }
    
    func getAll() -> Array<SGTMVVMTableCellViewModel> {
        return datas
    }
    
}

extension SGTMVVMTableDataSection: Sequence, IteratorProtocol {
    //    GET
    subscript(index: Int) -> SGTMVVMTableCellViewModel? {
        get {
            return datas.safeGet(index)
        }
        
        set(newValue) {
            guard newValue != nil else {return}
            guard index < datas.count else {self.append(newValue!);return}
            self.replace(newValue!, atIndex: index)
        }
    }
    
    public func next() -> SGTMVVMTableCellViewModel? {
        if _iteratorCount == -1 {
            _iteratorCount = self.datas.count
        }
        if _iteratorCount > 0 {
            defer {
                _iteratorCount -= 1
            }
            return self[self.datas.count - _iteratorCount]
        } else {
            defer {
                _iteratorCount = -1
            }
            return nil
        }
    }
}
//MARK: - add modify delete
extension SGTMVVMTableDataSection {
    //    ADD
    func append(_ viewModel: SGTMVVMTableCellViewModel) {
        let indexPath = IndexPath(row: datas.count, section: self.section)
        datas.append(viewModel)
        self.dataChangeObserver.send(value: SGTMVVMTableDataChanedStatus(type: .insertion,changeIndexes: [indexPath]))
    }
    
    func appendAll(_ viewModels: Array<SGTMVVMTableCellViewModel>) {
        let  indexs = self.indexsFrom(start: datas.count, count: viewModels.count, section: self.section)
        datas.append(contentsOf: viewModels)
        self.dataChangeObserver.send(value: SGTMVVMTableDataChanedStatus(type: .insertion,changeIndexes: indexs))
    }
    
    func insert(_ data: SGTMVVMTableCellViewModel, at index: Int) {
        if self.datas.count > index {
            self.datas.insert(data, at: index)
            let indexPath = IndexPath(row: index, section: self.section)
            self.dataChangeObserver.send(value: SGTMVVMTableDataChanedStatus(type: .insertion,changeIndexes: [indexPath]))
        }else {
            self.append(data)
        }
    }
    
    //    DELET
    func removeAll(){
        self.datas.removeAll()
        let  indexs = self.indexsFrom(start: 0, count: datas.count, section: self.section)
        self.dataChangeObserver.send(value: SGTMVVMTableDataChanedStatus(type: .removal,changeIndexes: indexs))
    }
    
    func remove(_ index: Int) {
        let indexPath = IndexPath(row: index, section: self.section)
        self.datas.remove(index)
        self.dataChangeObserver.send(value: SGTMVVMTableDataChanedStatus(type: .removal,changeIndexes: [indexPath]))
    }
    
    func removeLast() {
        if self.datas.count <= 0 {
            return
        }
        self.datas.removeLast()
        let indexPath = IndexPath(row: self.datas.count, section: self.section)
        self.dataChangeObserver.send(value: SGTMVVMTableDataChanedStatus(type: .removal,changeIndexes: [indexPath]))
    }
    
    //    MODIFY
    func replaceAllWith(_ data: Array<SGTMVVMTableCellViewModel>){
        self.datas.removeAll()
        self.datas.append(data)
        let  indexs = self.indexsFrom(start: 0, count: datas.count, section: self.section)
        self.dataChangeObserver.send(value: SGTMVVMTableDataChanedStatus(type: .replacement,changeIndexes: indexs))
    }
    
    func replace(_ data: SGTMVVMTableCellViewModel, atIndex index: Int) {
        
        if self.datas.count > index {
            self.datas[index] = data
            let indexPath = IndexPath(row: index, section: self.section)
            self.dataChangeObserver.send(value: SGTMVVMTableDataChanedStatus(type: .replacement,changeIndexes: [indexPath]))
            
        }else {
            self.append(data)
        }
    }
    
    fileprivate func indexsFrom(start: Int, count:Int, section: Int) -> [IndexPath] {
        var indexs = Array<IndexPath>()
        for i in 0..<count {
            let indexPath = IndexPath(row: start+i, section: section)
            indexs.append(indexPath)
        }
        return indexs
    }
}
