//
//  SGTMVVMPageRoute.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/15.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit

public protocol URLRouteMapperProtocol {
    func viewModelClassForURL(_ url:String) -> AnyClass
}

public class SGTMVVMPageRouter: NSObject {
    
    static public var routeMapperDelegate: URLRouteMapperProtocol?
    
    class func sharedRouter() ->SGTMVVMPageRouter {
        struct Static {
            static let sharedInstance = SGTMVVMPageRouter()
        }
        return Static.sharedInstance
    }
    
    public class func viewForViewModel(_ vm:SGTMVVMViewModelProtocol) -> UIView {
        
        guard let viewClass = vm.viewClass() as? SGTMVVMViewProtocol.Type else {
            SGTLogError("\(vm.viewClass()) was not instance of SGTMVVMViewProtocol")
            return UIView()//SGTReactView(viewModel: vm)
        }
        if let instance = viewClass.init(viewModel:vm).getReactView() {
            return instance
        }else {
            SGTLogError("\(vm.viewClass()) was instance of SGTMVVMViewProtocol but get empty view from method getReactView ")
            return UIView()
        }
    }
    
    public class func viewControllerForViewModel(_ vm:SGTMVVMViewModelProtocol) -> UIViewController {
        guard let viewClass = vm.viewClass() as? SGTMVVMViewProtocol.Type else {
            SGTLogError("viewControllerForViewModel was not found or not initlized to //@objc")
            return UIViewController()
        }
        let instance = viewClass.init(viewModel:vm)
        return instance as! UIViewController
    }
    
    
//    override class func swiftClassFromString(_ className: String) -> AnyClass! {
//        if let cls =  swiftClassFromString(className, nameSpace :"SGTReactView"){
//            return cls
//        }
//        assert(app_name != nil, "appName 必须设置")
//        var appName = app_name!
//        if (appName as AnyObject).range(of: "-").location != NSNotFound {
//            appName = (appName as AnyObject).replacingOccurrences(of: "-", with: "_")
//        }
//        let classStringName = "_TtC\((appName as AnyObject).length())\(appName)\(className.length())\(className)"
//        let  cls: AnyClass? = NSClassFromString(classStringName)
//        assert(cls != nil, "class not found,please check className")
//        return cls
//    }
    
    public class func viewControllerForURL(_ url:String, params:Dictionary<String,Any>?,service: SGTMVVMPageRouteServicesProtocol) -> UIViewController{
        if isLegalURL(url) {
            let vm = viewModelForURL(url, params: params, service: service)
            return viewControllerForViewModel(vm)
        }else {
            SGTLogError("\(url) was not LegalURL")
            return UIViewController()//viewControllerForViewModel(SGT404ViewModel(service:service))
        }
    }
    
    public class func viewModelForURL(_ url:String, params:Dictionary<String,Any>?,service: SGTMVVMPageRouteServicesProtocol) -> SGTMVVMViewModelProtocol {
        
        if routeMapperDelegate == nil {
            SGTLogError("routeMapperDelegate was not initialize, please give a value first and send message to viewModelForURL func")
            return SGTMVVM404ControllerViewModel(service:service)
        }else {
            if let clz = routeMapperDelegate?.viewModelClassForURL(url) {
                if let vcs = clz as? SGTMVVMURLOpenableViewModelProtocol.Type {
                    if vcs.avaliableForParam(params) {
                        if let viewModel = vcs.init(service: service, param: params) as? SGTMVVMViewModelProtocol {
                            return viewModel
                        }
                    }
                }
            }else {
                SGTLogError("get empty class from url \(url)")
            }
            return SGTMVVM404ControllerViewModel(service:service)
        }
    }
    
    public class func isLegalURL(_ url:String?) -> Bool{
        return true
    }
    
}
public class RouteClass: NSObject {
    public var className: String
    public var params: Dictionary<String,AnyObject>
    init(className:String,params:Dictionary<String,AnyObject>){
        self.className = className
        self.params = params
        super.init()
    }
}
