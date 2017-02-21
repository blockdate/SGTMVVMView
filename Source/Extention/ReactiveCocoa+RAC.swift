////
////  ReactiveCocoa+RAC.swift
////  YiDang-OC
////
////  Created by 磊吴 on 15/10/19.
////  Copyright © 2015年 block. All rights reserved.
////
//
//import Foundation
//import ReactiveObjC
//public struct SGTRAC  {
//    var target : NSObject!
//    var keyPath : String!
//    var nilValue : Any!
//    
//    public init(_ target: NSObject!, _ keyPath: String, _ nilValue: Any? = nil) {
//        self.target = target
//        self.keyPath = keyPath
//        self.nilValue = nilValue
//    }
//    
//    public func assignSignal(_ signal : RACSignal) {
//        signal.setKeyPath(self.keyPath, on: self.target, nilValue: self.nilValue)
//    }
//}
//
//infix operator ~>
//public func ~> (signal: RACSignal, rac: SGTRAC) {
//    rac.assignSignal(signal)
//}
//
//infix operator <~ 
//public func <~ (rac: SGTRAC, signal: RACSignal) {
//    
//    rac.assignSignal(signal)
//    
//}
//
//
//extension RACSignal {
////    func subscribeNextAs<T>(_ nextClosure:@escaping (T) -> ()) -> () {
////        self.subscribeNext {
////            (next: AnyObject!) -> () in
////            let nextAsT = next as! T
////            nextClosure(nextAsT)
////        }
////    }
//}
//
//public func RACObserve(_ target: NSObject!, keyPath: String) -> RACSignal  {
//    return target.rac_values(forKeyPath: keyPath, observer: target)
//}
