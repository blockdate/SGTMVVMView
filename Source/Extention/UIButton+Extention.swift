//
//  UIButton+Extention.swift
//  EasyPawnShop
//
//  Created by 磊吴 on 15/10/14.
//  Copyright © 2015年 block. All rights reserved.
//

import UIKit

public extension UIButton {
    public func sgt_cover(_ radius:CGFloat, borderWidth:CGFloat, color:UIColor) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }
    
    public class func generate(_ title:String, titleColor:UIColor) ->UIButton{
        return UIButton.generate(title, titleColor: titleColor, bgColor: UIColor.clear, target: nil, action: nil)
    }
    
    public class func generate(_ title:String, titleColor:UIColor, bgColor:UIColor, target:AnyObject?, action:Selector?) ->UIButton{
        let button = UIButton(type: UIButtonType.custom)
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(titleColor, for: UIControlState())
        button.backgroundColor = bgColor
        if target != nil && action != nil {
            button.addTarget(target!, action: action!, for: UIControlEvents.touchUpInside)
        }
        return button
    }
}
