//
//  SGTMVVMNetReachablity.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/17.
//  Copyright © 2017年 sgt. All rights reserved.
//

import Foundation
import ReactiveSwift
//import AFNetworking

open class SGTNetReachablity: NSObject {
    
//    open static var netStatue:AFNetworkReachabilityStatus?
//    
//    public static var netReachablity = MutableProperty<Bool>(true)
//    
//    open class func isNetAvaliable() ->Bool {
//        if netStatue != nil {
//            if netStatue! == AFNetworkReachabilityStatus.reachableViaWiFi || netStatue == AFNetworkReachabilityStatus.reachableViaWWAN {
//                return true
//            }else {
//                return false
//            }
//        }
//        return true
//    }
//    
//    open class func setupNetFunction() {
//        DispatchQueue.once(token: "") { () in
//            AFNetworkReachabilityManager.shared().setReachabilityStatusChange { (status) -> Void in
//                SGTNetReachablity.netStatue = status
//                switch status {
//                case .notReachable:
//                    SGTNetReachablity.netReachablity.consume(false)
//                    break
//                case .reachableViaWiFi:
//                    SGTNetReachablity.netReachablity.consume(true)
//                    break
//                case .reachableViaWWAN:
//                    SGTNetReachablity.netReachablity.consume(true)
//                    break
//                case .unknown:
//                    SGTNetReachablity.netReachablity.consume(false)
//                    break
//                }
//            }
//        }
//        AFNetworkReachabilityManager.shared().startMonitoring()
//        
//    }
//    
//    open class func stopFunction() {
//        AFNetworkReachabilityManager.shared().stopMonitoring()
//    }
}
