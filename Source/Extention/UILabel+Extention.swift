//
//  UILabel+Extention.swift
//  EasyPawnShop
//
//  Created by 磊吴 on 15/10/15.
//  Copyright © 2015年 block. All rights reserved.
//

import UIKit

private var key_defaultFont = ""
public extension UILabel {
    
//    public var defaultFont: UIFont {
//        get{
//            if let size = objc_getAssociatedObject(self, &key_defaultFont) as? UIFont {
//                return size
//            }
//            return UIFont.systemFont(ofSize: SGTTextSize.contentNormal)
//        }
//        set{
//            objc_setAssociatedObject(self, &key_defaultFont, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
//            objc_setAssociatedObject(self, &key_defaultFont, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            
//        }
//    }
    
    public class func generate(_ title: String, font: CGFloat) ->UILabel {
        return UILabel.generate(title, font: font, titleColor: nil)
    }
    
    public class func generate(_ title: String, font: CGFloat, titleColor: UIColor?) ->UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: font)
        label.textColor = titleColor
        return label
    }
    
}
