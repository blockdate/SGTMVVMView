//
//  NSObject+Extension.swift
//  YiDang-OC
//
//  Created by 磊吴 on 16/2/15.
//  Copyright © 2016年 block. All rights reserved.
//

import Foundation

//MARK: - String To Class
extension NSObject {
    class func swiftClassFromString(_ className: String) -> AnyClass! {
        if let cls =  swiftClassFromString(className, nameSpace :"SGTMVVMView"){
            return cls
        }
        
        if var appName = Bundle.main.infoDictionary?["\(kCFBundleExecutableKey)"] {
            if (appName as AnyObject).range(of: "-").location != NSNotFound {
                appName = (appName as AnyObject).replacingOccurrences(of: "-", with: "_")
            }
            let classStringName = "_TtC\((appName as AnyObject).length())\(appName)\(className.length())\(className)"
            let  cls: AnyClass? = NSClassFromString(classStringName)
            assert(cls != nil, "class not found,please check className")
            return cls
        }
        
        SGTLogWarn("class:\(className) not found")
        return nil
    }
    class func swiftClassFromString(_ className: String, nameSpace: String) -> AnyClass! {
        let appName = nameSpace
        let classStringName = "_TtC\(appName.length())\(appName)\(className.length())\(className)"
        let  cls: AnyClass? = NSClassFromString(classStringName)
        return cls
    }
}


