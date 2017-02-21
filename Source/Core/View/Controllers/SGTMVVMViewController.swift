//
//  SGTMVVMViewController.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/15.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import MBProgressHUD
import SGTUIKit
import SGTNetworking

class SGTMVVMNavigationController: UINavigationController {
    
}

open class SGTMVVMViewController:UIViewController, SGTMVVMViewProtocol {
    
    open fileprivate(set) var vm: SGTMVVMViewModelProtocol
    
    /// whether the controller was pushed
    public var pushed = MutableProperty<Bool>(false)
    
    /// a invisable view used to show the hud when needed
    fileprivate var hudOverLayView: UIView!
    
    /// hud view to show info
    fileprivate weak var overLayViewHUDView: MBProgressHUD?
    
    /// is current net reachable
    public var networkReachable: MutableProperty<Bool> {return (vm as! SGTMVVMControllerViewModel).networkReachable}
    
    required public init(viewModel: SGTMVVMViewModelProtocol) {
        self.vm = viewModel
        let nibName: String? = viewModel.nibExist() ? "\(type(of: self))" : nil
        super.init(nibName: nibName, bundle: Bundle.main)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("SGTMVVMViewController init with adecoder was not correct, change to use init(viewModel:) instead")
    }
    
    deinit {
        SGTMVVMViewController.cancelPreviousPerformRequests(withTarget: self)
        NotificationCenter.default.removeObserver(self)
        SGTLogDebug("\(type(of: self)):\(#function)")
    }
    
    open func viewType() -> SGTMVVMViewType {
        return .controller
    }
    
    open func getReactView() -> UIView? {
        return self.view
    }
    
    open func bind(_ viewModel: SGTMVVMViewModelProtocol) {
        if let controllerViewModel = vm as? SGTMVVMControllerViewModel {
            controllerViewModel.executingSignal.observeValues({[weak self] (execute) in
                if execute {
                    self?.showHUD("")
                }else {
                    self?.hideHUD()
                }
            })
            controllerViewModel.errorSignal.observeValues({[weak self] (error) in
                self?.handleError(error: error)
            })
        }else {
            SGTLogError("bind a view controller with a unknow viewmodel instand of SGTCOntrollerViewModel ")
        }
    }
    
    open func unBind(_ viewModel: SGTMVVMViewModelProtocol) {
        
    }
}

//    MARK: - Life Cycle
extension SGTMVVMViewController {
    
    public func getController() -> SGTMVVMViewController? {
        return self
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        initializeNetNotify()
        bind(vm)
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        SGTLogWarn("didReceiveMemoryWarning")
        //        if(self.view.window == nil) {
        //            self.view = nil
        //        }
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let viewModel = vm as? SGTMVVMControllerViewModel else {
            return
        }
        viewModel.willDisappearObserver.send(value: true)
        self.view.endEditing(true)
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let viewModel = vm as? SGTMVVMControllerViewModel else {
            return
        }
        viewModel.willAppearObserver.send(value: true)
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let viewModel = vm as? SGTMVVMControllerViewModel else {
            return
        }
        viewModel.didAppearObserver.send(value: true)
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let viewModel = vm as? SGTMVVMControllerViewModel else {
            return
        }
        viewModel.didDisappearObserver.send(value: true)
    }
    
    func netAvaliabeChanged(_ avaliable:Bool) {
        self.networkReachable.consume(avaliable)
    }
    
    /// show or hide the net work unreachable view
    ///
    /// - Parameter networkReachable: is the network reachabel
    open func showNetworkUnReachableView(networkReachable: Bool) {
        
    }
    
}

//    MARK: - Alert
extension SGTMVVMViewController {
    //    MARK: - Picker 快捷方式
//    public func showPicker(_ arr:[String], finish:@escaping (Int)->Void) {
//        let view = SGTNormalPickerView(frame: CGRect(x: 0, y: 0, width: SGTUtilScreenSize.screenWidth, height: 300), textArr: arr, selectFinish:finish)
//        self.view.addSubview(view)
//        view.snp.makeConstraints { (make) -> Void in
//            let _ = make.left.bottom.right.equalTo(self.view)
//            let _ = make.height.equalTo(300)
//        }
//    }
    //    MARK: - Alert相关
    public func showSuccessAlert(_ title: String?, subtitle: String? ) {
        self.showSuccessAlert(title, subtitle: subtitle, closeText: "知道了", alertAddition: nil)
    }
    
    public func showSuccessAlert(_ title: String?, subtitle: String?, closeText: String, alertAddition:((_ alert:SCLAlertView) ->Void)?) {
        let alert = SCLAlertView()
        alertAddition?(alert)
        alert.showSuccess(title ?? "", subTitle: subtitle ?? "", closeButtonTitle: closeText, duration: 0.0)
    }
    
    public func showErrorAlert(_ title: String?, subtitle: String? ) {
        self.showErrorAlert(title, subtitle: subtitle, closeText: "知道了", alertAddition: nil)
    }
    
    public func showErrorAlert(_ title: String?, subtitle: String?, closeText: String, alertAddition:((_ alert:SCLAlertView) ->Void)?) {
        let alert = SCLAlertView()
        alertAddition?(alert)
        alert.showError(title ?? "", subTitle: subtitle ?? "", closeButtonTitle: closeText, duration: 0.0)
    }
    
    public func showInfoAlert(_ title: String?, subtitle: String? ) {
        self.showInfoAlert(title, subtitle: subtitle, closeText: "知道了", alertAddition: nil)
    }
    
    public func showInfoAlert(_ title: String?, subtitle: String?, closeText: String, alertAddition:((_ alert:SCLAlertView) ->Void)?) {
        //        let alert = SGTAlertView()
        //        alert.showCustom(title!, subTitle: subtitle!, color: SGTColor.system, icon: SGTAlertViewStyleKit.imageOfInfo, closeButtonTitle: "", duration: 0.0, colorStyle: 0, colorTextButton: 0, circleIconImage: nil, animationStyle: SGTAnimationStyle.noAnimation)
        //        alertAddition?(alert: alert)
        //        alert.showCustom(SGTAlertViewStyleKit.imageOfInfo(), color: SGTColor.system,title:  "", subTitle: "", closeButtonTitle: "", duration: 0.0)
        //        alert.showCustom(SCLAlertViewStyleKit.imageOfInfo(), color: SGTColor.system, title: "", subTitle: "", closeButtonTitle: closeText, duration: 0.0)
    }
    
}

//MARK: - DataBinding
extension SGTMVVMViewController {
    
    fileprivate func p_barButtonItem(_ navItem: SGTNavItem,color: UIColor, font:UIFont) -> UIBarButtonItem {
        
        if navItem.image != nil && navItem.title != nil {
            let view = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            view.setImage(navItem.image, for: UIControlState())
            view.setTitleColor(color, for: UIControlState())
            view.setTitle(navItem.title, for: UIControlState())
            view.titleLabel?.font = font
            view.contentMode = UIViewContentMode.center
            let item = UIBarButtonItem(customView: view)
            item.reactive.pressed = navItem.selectCommand
            return item
        }else if navItem.image != nil{
            let item = UIBarButtonItem(image: navItem.image, style: .plain, target: nil, action: nil)
            item.reactive.pressed = navItem.selectCommand
            return item
        }else if navItem.title != nil {
            let item = UIBarButtonItem(title: navItem.title, style: .plain, target: nil, action: nil)
            item.reactive.pressed = navItem.selectCommand
            return item
        }else {
            let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            item.reactive.pressed = navItem.selectCommand
            return item
        }
        
    }
    
    fileprivate func initializeHUDRelate() {
        self.hudOverLayView = UIView(frame: CGRect(x: 0,y: 0,width: SGTUtilScreenSize.screenWidth,height: SGTUtilScreenSize.screenHeight))
        hudOverLayView.tag = 0
        hudOverLayView.backgroundColor = UIColor.clear
        hudOverLayView.isHidden = true
        self.view.addSubview(hudOverLayView)
    }
    
    fileprivate func initializeNavRealate() {
        guard let viewModel = vm as? SGTMVVMControllerViewModel else {
            return
        }
        self.navigationController?.navigationBar.lt_setbottomLineHide(true)
        
        self.navigationItem.title = viewModel.titleText
        
        var leftNavItem: UIBarButtonItem?
        var rightNavItem: UIBarButtonItem?
        if viewModel.leftNavItem != nil {
            leftNavItem = p_barButtonItem(viewModel.leftNavItem!,color: viewModel.navTitleColor,font: SGTTextFont.contentNormal)
        }
        if viewModel.rightNavItem != nil {
            rightNavItem = p_barButtonItem(viewModel.rightNavItem!,color: viewModel.navTitleColor,font: SGTTextFont.contentNormal)
        }
        if self.pushed.value {
            var arr:Array<UIBarButtonItem> = []
            if leftNavItem != nil {
                arr.append(leftNavItem!)
            }
            if rightNavItem != nil {
                arr.append(rightNavItem!)
            }
            self.navigationItem.rightBarButtonItems = arr
            
            if viewModel.backNavImage != nil {
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: viewModel.backNavImage!, style: .plain, target: self, action: #selector(SGTMVVMViewController.navigationStartBack))
            }
        }else {
            self.navigationItem.leftBarButtonItem = leftNavItem
            self.navigationItem.rightBarButtonItem = rightNavItem
        }
        if viewModel.navBarStyle.contains(SGTNavBarStyle.Search) {
            //                initializeSearchNav()
        }
    }
    
    func initializeView() {
        
        self.initializeHUDRelate()
        
        self.initializeNavRealate()
        
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = UIRectEdge();
        
    }
    
    func initializeNetNotify(){
        self.networkReachable <~ SGTNetReachablity.netReachablity
        SGTNetReachablity.netReachablity.signal.observeValues {[weak self] (netReachable) in
            guard let controller = self else {
                return
            }
            controller.showNetworkUnReachableView(networkReachable: netReachable)
        }
    }
    
}

//  MARK: - HUD相关
extension SGTMVVMViewController {
    
    /// show the given text in hud, auto counting is used. e.g showHUD with x times, then hideHUD should call the same time then the hud can be hide
    ///
    /// - Parameter text: hud text
    public func showHUD(_ text:String?) {
        if self.hudOverLayView.tag == 0 {
            self.p_showHUD(text)
        }else {
            self.modifyHUDTagWith(1)
        }
        if let hud = self.overLayViewHUDView {
            hud.label.text = text ?? ""
        }
    }
    
    /// hide the hud view
    public func hideHUD() {
        //        SGTLogInfo("should hide hud")
        let tag = self.hudOverLayView.tag
        if tag == 1 {
            self.p_hideHUD()
        }else if tag > 1 {
            self.modifyHUDTagWith(-1)
        }else {
            return
        }
        
    }
    
    fileprivate func modifyHUDTagWith(_ number:Int) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).sync {
            self.hudOverLayView.tag += number
        }
    }
    
    fileprivate func p_showHUD(_ text:String?) {
        //        SGTLogInfo("show hud")
        self.modifyHUDTagWith(1)
        DispatchQueue.main.async { () -> Void in
            self.overLayViewHUDView = MBProgressHUD.showAdded(to: self.hudOverLayView, animated: true)
            self.overLayViewHUDView?.label.text = text ?? ""
            self.view.bringSubview(toFront: self.hudOverLayView)
            self.hudOverLayView.isHidden = false
        }
    }
    
    fileprivate func p_hideHUD() {
        //        SGTLogInfo("hide hud")
        self.modifyHUDTagWith(-1)
        DispatchQueue.main.async { () -> Void in
            guard self.hudOverLayView != nil else {
                return
            }
            MBProgressHUD.hide(for: self.hudOverLayView, animated: true)
            self.hudOverLayView.isHidden = true
            self.view.sendSubview(toBack: self.hudOverLayView)
        }
    }
    
}

//  MARK: - Error handle
extension SGTMVVMViewController {
    
    open func handleError(error: NSError) {
        if error.code == 0001 || error.code == 803 || error.code == 805{
            switch error.code{
            case 0001,805:  // 默认提示处理
                var errorStr:String?
                if error.code == 0001 {
                    errorStr = error.domain
                }else {
                    errorStr = "请登录以获取数据..."
                }
                
                self.showHint(errorStr!)
                break
            case 803:
                self.showHint("身份信息已过期,请重新登录")
                break
            default:
                break
            }
        }else {
            let e = NetWorkError(error:error)
            switch e {
            case .notConnectedToInternet:
                self.showHint("网络似乎未连接")
            case .internationalRoamingOff:
                self.showHint("网络出错")
            case .notReachedServer:
                self.showHint("服务器开小差啦！")
            case .incorrectDataReturned:
                self.showHint("服务器返回数据错误")
            case .unknown:
                self.showHint(error.domain)
            default:
                self.showHint(error.domain)
            }
        }
    }
    
}

//    MARK: - 导航条便捷方式
extension SGTMVVMViewController {
    
    public func navigationStartBack() {
        self.view.endEditing(true)
        let _ = self.navigationController?.popViewController(animated: true)
        if let viewModel = vm as? SGTMVVMControllerViewModel {
            viewModel.didPopObserver.send(value: true)
        }
    }
    
    public func hideNavigationBar(_ hiden:Bool) {
        self.navigationController?.navigationBar.isHidden = hiden
    }
    
    public func setNavigationBarTitle(_ title: String?) {
        self.navigationItem.title = title
    }
    
    public func setNavigationBarBack() {
        pushed.consume(true)
    }
    
}
