//
//  UIImageView+Extension.swift
//  EasyPawnShop
//
//  Created by 磊吴 on 15/10/15.
//  Copyright © 2015年 block. All rights reserved.
//

import UIKit

public extension UIImageView {
    public func sgt_radius(_ radius:CGFloat, borderWidth:CGFloat, color:UIColor) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }
}

public extension UIImage {
    
    public class func createImage(_ orignalImage:UIImage, size: CGSize, waterMarkImage: UIImage?) ->UIImage{
        UIGraphicsBeginImageContext(size)
        orignalImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        waterMarkImage?.draw(in: CGRect(x: size.width/2, y: 0, width: size.width/2, height: size.height/2 > 20 ? 20 : size.height/2))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    public class func createImage(_ color:UIColor, size:CGSize) ->UIImage{
        UIGraphicsBeginImageContext(size)
        color.setFill()
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
