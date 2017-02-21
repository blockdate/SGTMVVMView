//
//  SGTMVVMInject.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/15.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit

class SGTMVVMInject: NSObject {
    
    private class func inject<T>(_ selector: ()->AnyObject) -> T{
        let object = selector()
        let result = object as! T
        return result
    }
    
    class func inject<Type>() -> Type {
        let injectName = "\(Type.self)"
        
        if let obj: Type = SGTMVVMAssembly.instanceForClass(className: injectName) {
            return obj;
        }else if let classC = NSObject.swiftClassFromString(injectName) {
            let obj: Type = SGTMVVMAssembly.instanceForClass(classC: classC)
            return obj
        }
        fatalError("injectSignle error , class name :\(injectName)was not found.")
    }
        
}
