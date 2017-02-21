//
//  Array+Extension.swift
//  YiDang-OC
//
//  Created by 磊吴 on 16/3/16.
//  Copyright © 2016年 block. All rights reserved.
//

import UIKit
extension Array {
    public func getIndex(_ index: Int) ->Element? {
        
        guard index <= self.count-1 else {
            return nil
        }
        return self[index]
    }
}

extension NSArray {
    public func getIndex(_ index: Int) ->Element? {
        
        guard index <= self.count-1 else {
            return nil
        }
        return self[index]
    }
}

extension Array {
    public func safeGet(_ index:Int) ->Element? {
        guard self.count > index else {return nil}
        return self[index]
    }
    
}

extension Array {
    public var isNotEmpty: Bool {
        return !isEmpty
    }
    
    public func hasIndex(_ index: Int) -> Bool {
        return indices ~= index
    }
    
    //    public func getSafeIndex(_ index: Int) -> Int {
    //        let mIndex = max(0, index)
    //        return min(count, mIndex)
    //    }
    
    public func getSafeRange(_ range: Range<Int>) -> CountableRange<Int>? {
        let start = range.lowerBound > 0 ? range.lowerBound : 0 ;//max(0, range.lowerBound)
        let end = range.upperBound < count ? range.upperBound : count//min(count, range.upperBound)
        return start <= end ? start..<end : nil
    }
    
    public func get(_ index: Int) -> Element? {
        return hasIndex(index) ? self[index] : nil
    }
    
    @discardableResult public mutating func append(_ newArray: Array) -> CountableRange<Int> {
        let range = count..<(count + newArray.count)
        self += newArray
        return range
    }
    
    //    @discardableResult public mutating func insert(_ newArray: Array, atIndex index: Int) -> CountableRange<Int> {
    //        let mIndex = max(0, index)
    //        let start = min(count, mIndex)
    //        let end = start + newArray.count
    //
    //        let left = self[0..<start]
    //        let right = self[start..<count]
    //        self = left + newArray + right
    //        return start..<end
    //    }
    
    @discardableResult public mutating func move(fromIndex from: Int, toIndex to: Int) -> Bool {
        if !hasIndex(from) || !hasIndex(to) || from == to {
            return false
        }
        
        if let fromItem = get(from) {
            remove(from)
            insert(fromItem, at: to)
            return true
        }
        return false
    }
    
    @discardableResult public mutating func remove(_ index: Int) -> CountableRange<Int>? {
        if !hasIndex(index) {
            return nil
        }
        self.remove(at: index)
        return index..<(index + 1)
    }
    
    @discardableResult public mutating func remove(_ range: Range<Int>) -> CountableRange<Int>? {
        if let sr = getSafeRange(range) {
            removeSubrange(sr)
            return sr
        }
        return nil
    }
    
    @discardableResult public mutating func remove<T: AnyObject> (_ element: T) {
        let anotherSelf = self
        
        removeAll(keepingCapacity: true)
        
        anotherSelf.each { (index: Int, current: Element) in
            if (current as! T) !== element {
                self.append(current)
            }
        }
    }
    
    //    mutating func removeLast() -> Range<Int>? {
    //        return remove(count - 1)
    //    }
    
    public func each(_ exe: (Int, Element) -> ()) {
        for (index, item) in enumerated() {
            exe(index, item)
        }
    }
}
