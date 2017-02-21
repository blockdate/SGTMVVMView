//
//  SGTMVVMAssembly.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/15.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit
import Typhoon

open class SGTMVVMAssembly: TyphoonAssembly {
    
    static var classRegistDic: Dictionary<String,Selector> = Dictionary()
    
    static let singleton = SGTMVVMAssembly().activate()
    
    public class func sharedAssembly() -> SGTMVVMAssembly {
        return self.singleton!
    }
    
    open dynamic func pageRouteService() -> AnyObject {
        return TyphoonDefinition.withClass(SGTViewModelPageRouteService.self, configuration: { (definition) in
            definition?.scope = TyphoonScope.singleton
        }) as AnyObject
    }
    
    open class func instanceForClass<T>(classC: AnyClass) -> T {
        self.sharedAssembly().preRegist()
        let className = "\(classC.self)"
        if let sel = SGTMVVMAssembly.classRegistDic[className] {
            return self.sharedAssembly().perform(sel) as! T
        }else {
            fatalError("\(className) was not registed")
        }
    }
    
    open class func instanceForClass<T>(className: String) -> T {
        self.sharedAssembly().preRegist()
        if let sel = SGTMVVMAssembly.classRegistDic[className] {
            let obj = self.sharedAssembly().perform(sel).takeUnretainedValue()

            return obj as! T
        }else {
            fatalError("\(className) was not registed")
        }
    }
    
    func preRegist() {
        DispatchQueue.once(token: "pageRouteService") { () in
            SGTMVVMAssembly.classRegistDic["\(SGTViewModelPageRouteService.self)"] = #selector(SGTMVVMAssembly.pageRouteService)
            SGTMVVMAssembly.classRegistDic["\(SGTMVVMPageRouteServicesProtocol.self)"] = #selector(SGTMVVMAssembly.pageRouteService)
        }
        
        
    }
    
}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block:(Void)->Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}
