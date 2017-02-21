//
//  UIView+Extension.swift
//  YiDang-OC
//
//  Created by 磊吴 on 16/1/26.
//  Copyright © 2016年 block. All rights reserved.
//

import UIKit

private var indecatorKey = ""

public extension UIView {
    public func showIndecator(_ size:CGSize = CGSize(width: 20, height: 20)) {
        if let indecator = objc_getAssociatedObject(self, &indecatorKey) as? UIActivityIndicatorView{
            self.addSubview(indecator)
            indecator.startAnimating()
        }else {
            let indecator = UIActivityIndicatorView(frame: CGRect(x: 0,y: 0,width: size.width,height: size.height))
            objc_setAssociatedObject(self, &indecatorKey, indecator, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.addSubview(indecator)
            indecator.center = self.center
            indecator.startAnimating()
        }
    }
    
    public func hideIndecator() {
        if let indecator = objc_getAssociatedObject(self, &indecatorKey) as? UIActivityIndicatorView{
            indecator.stopAnimating()
            indecator.removeFromSuperview()
        }else {
            SGTLogError("未找到 \(self)的 UIActivityIndicatorView")
        }
    }
    
}
