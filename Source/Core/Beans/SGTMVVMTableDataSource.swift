//
//  SGTMVVMTableDataSource.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/16.
//  Copyright © 2017年 sgt. All rights reserved.
//

import Foundation
import ReactiveSwift
import enum Result.NoError

open class SGTMVVMTableDataSource: NSObject {
    
    /// the section data Array
    var datas: Array<SGTMVVMTableDataSection> = Array()
    
    fileprivate var _iteratorCount: Int = -1
    
    /// notify change when data of section has changed.
    /// e.g data[0].append(xxx) will triggle the signal, but data.removefirst() will not
    public fileprivate(set) var (rowDataChangeSignal, rowDataChangeObserver) = Signal<SGTMVVMTableDataChanedStatus<IndexPath>, NoError>.pipe()
    
    /// notify change when section changed.
    /// e.g data[0].append(xxx) will not triggle the signal, but data.removefirst() will
    public fileprivate(set) var (sectionDataChangeSignal, sectionDataChangeObserver) = Signal<SGTMVVMTableDataChanedStatus<Int>, NoError>.pipe()

}

extension SGTMVVMTableDataSource: Sequence, IteratorProtocol {
    //    GET
    subscript(index: Int) -> SGTMVVMTableDataSection? {
        get {
            return datas.safeGet(index)
        }
        
        set(newValue) {
//            guard newValue != nil else {return}
//            guard index < datas.count else {self.append(newValue!);return}
//            self.replace(newValue!, atIndex: index)
        }
    }
    
    public func next() -> SGTMVVMTableDataSection? {
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

extension SGTMVVMTableDataSource {
    
    open func sectionCount() -> Int {
        return datas.count
    }
    
    open func totalVMCount() -> Int {
        var count = 0
        for section in self.datas {
            count += section.count
        }
        return count
    }
    
    open func rowCountAtSection(_ section: Int) -> Int {
        return datas[section].count
    }
    
    open func viewModelFor(_ section: Int, _ row: Int) -> SGTMVVMTableCellViewModel? {
        return datas[section][row]
    }

}

public extension SGTMVVMTableDataSource {
    //    GET
    
    fileprivate func sectionDataChanged(type:NSKeyValueChange, sections:[Int]) {
        self.sectionDataChangeObserver.send(value: SGTMVVMTableDataChanedStatus(type: type, changeIndexes: sections))
    }
    
    fileprivate func sectionWith(start: Int, count: Int) -> [Int] {
        var sections = Array<Int>()
        for i in 0..<count {sections.append(i)}
        return sections
    }
    
//    MARK: ADD OR INSERT
    /// add a vm arr to the section of index, do nothing when the section of index not exist
    func append(_ data: Array<SGTMVVMTableCellViewModel>, atIndex index: Int) {
        if let g = self[index] {
            g.appendAll(data)
        }
    }
    
    /// add a vm array within a new section to the end
    func append(_ section: Array<SGTMVVMTableCellViewModel>){
        let sec = SGTMVVMTableDataSection(datas: section)
        sec.dataChangeSignal.observe(self.rowDataChangeObserver)
        self.datas.append(sec)
        self.sectionDataChanged(type: .insertion, sections: [self.datas.count-1])
    }
    
    /// inser a new section of viewmodel array at target index
    /// if index is out of range, the data will append the the end
    /// - Parameters:
    ///   - data: viewmodel array
    ///   - index: targe index
    func insert(_ data: Array<SGTMVVMTableCellViewModel>, at index: Int) {
        let g = SGTMVVMTableDataSection(datas: data)
        g.dataChangeSignal.observe(self.rowDataChangeObserver)
        if self.datas.count > index {
            self.datas.insert(g, at: index)
            self.sectionDataChanged(type: .insertion, sections: [index])
        }else {
            self.append(data)
        }
    }
    
//    MARK: DELET
    
    /// delete all the data
    func removeAll() {
        guard self.datas.count != 0 else {
            return
        }
        let sections = self.sectionWith(start: 0, count: self.datas.count)
        self.datas.removeAll()
        self.sectionDataChanged(type: .removal, sections: sections)
    }
    
    /// remove the target section
    ///
    /// - Parameter index: index section to remove
    func remove(_ index:Int) {
        if self.datas.count < index {
            self.datas.remove(index)
            self.sectionDataChanged(type: .removal, sections: [index])
        }
    }
//    MARK: MODIFY
    
    /// remove all the sections and use the data as new sections
    ///
    /// - Parameter data: new sections data
//    func replaceAllWith(_ data: Array<Array<SGTMVVMTableCellViewModel>>){
//        if self.datas.count == 0 {
//            
//        }else {
//            let  sections = self.sectionWith(start: 0, count: self.datas.count)
//            self.datas.removeAll()
//            self.sectionDataChanged(type: .removal, sections: sections)
//        }
//        let sections = self.sectionWith(start: 0, count: data.count)
//        for group in data {
//            let g = SGTMVVMTableDataSection(datas: group)
//            g.dataChangeSignal.observe(self.rowDataChangeObserver)
//            self.datas.append(g)
//        }
//        self.sectionDataChanged(type: .insertion, sections: sections)
//    }
    
    /// replace the target section by data
    /// if index is out of range ,the data will append to the end
    /// - Parameters:
    ///   - data: section data
    ///   - index: target section to replace
    func replace(_ data: Array<SGTMVVMTableCellViewModel>, atIndex index: Int) {
        let g = SGTMVVMTableDataSection(datas: data)
        g.dataChangeSignal.observe(self.rowDataChangeObserver)
        if self.datas.count > index {
            self.datas.remove(index)
            self.datas.insert(g, at: index)
        }else {
            self.datas.append(g)
        }
        self.sectionDataChanged(type: .replacement, sections: [index])
    }
    
    /// remove the last section
    func removeLast() {
        if self.datas.count <= 0 {
            return
        }
        self.datas.removeLast()
        self.sectionDataChanged(type: .removal, sections: [self.datas.count])
    }
    
}
