//
//  String+Extention.swift
//  EasyPawnShop
//
//  Created by 磊吴 on 15/10/13.
//  Copyright © 2015年 block. All rights reserved.
//

import UIKit

public extension String {
    
    public func subStringTo(_ index: Int) ->String {
        guard index<self.length() else {
            return self
        }
        
        let aimIndex = self.characters.index(self.startIndex, offsetBy: index)
        return self.substring(to: aimIndex)
    }
    
    public func length() ->Int {
        return self.characters.count
    }
    
    public var doubleValue:Double {
        return (self as NSString).doubleValue
    }
    
    public func isvalidateMobie() ->Bool{
        let phoneRegex = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$"
        let phoneText = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneText.evaluate(with: self)
    }
    
    public func sizeWithFont(_ font:CGFloat, maxWidth:CGFloat, lineSpace:CGFloat = 5) ->CGSize{
        let str:NSString? = self as NSString?
        let sy = NSMutableParagraphStyle()
        sy.lineSpacing = lineSpace
        
        let att = [NSFontAttributeName:UIFont.systemFont(ofSize: font),NSParagraphStyleAttributeName:sy]
        let size = str?.boundingRect(with: CGSize(width: maxWidth,height: 999), options: [.truncatesLastVisibleLine,.usesLineFragmentOrigin,.usesFontLeading], attributes: att, context: nil).size
        return size ?? CGSize.zero
    }
    
    public func isTelNumber()->Bool
    {
        let mobile = "^1(3[0-9]|5[0-35-9]|8[0-9]|4[57|7[0678]])\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[0127-9]|8[23478])\\d)\\d{8}$"
        let  CU = "^1(3[0-2]|4[57]|5[256]|8[56])\\d{8}$"
        let  CT = "^1(3[349]|53|8[09]|77)\\d{8}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: self) == true)
            || (regextestcm.evaluate(with: self)  == true)
            || (regextestct.evaluate(with: self) == true)
            || (regextestcu.evaluate(with: self) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    public func isEmpty() ->Bool {
        if self.length() == 0 {
            return true
        }
        return false
    }
    
    public func isPureNumber() ->Bool{
        if isPureInt() || isPureDouble() {
            return true
        }
        return false
    }
    public func isPureInt() -> Bool{
        let scan = Scanner(string: self as String)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
    public func isPureDouble() -> Bool{
        let scan = Scanner(string: self as String)
        var val:Double = 0
        return scan.scanDouble(&val) && scan.isAtEnd
    }
}

public func notEmptyOrNilString(_ obj:Any?) ->Bool {
    return !emptyOrNilString(obj)
}

public func emptyOrNilString(_ obj:Any?) -> Bool{
    if obj == nil {
        return true
    }
    if let str = obj as? String {
        return str.isEmpty()
    }
    if let str = obj as? NSAttributedString {
        return str.length == 0
    }
    return true
}

public func notEmptyOrNilArray(_ obj:Any?) ->Bool {
    return !emptyOrNilArray(obj)
}

public func emptyOrNilArray(_ obj:Any?) -> Bool{
    if obj == nil {
        return true
    }
    if let str = obj as? Array<AnyObject> {
        return str.count <= 0
    }
    return true
}

public extension NSMutableAttributedString {
    public class func attributeStringWithImage(_ image:UIImage) -> NSMutableAttributedString{
        let attch = NSTextAttachment()
        attch.image = image
        attch.bounds = CGRect(x: 0, y: -3, width: 15, height: 15)
        let attstr = NSAttributedString(attachment: attch)
        let mutstr = NSMutableAttributedString(attributedString: attstr)
        return mutstr
    }
    
    public class func attributeStringWithImageName(_ name:String) -> NSMutableAttributedString{
        let attch = NSTextAttachment()
        attch.image = UIImage(named: name)
        attch.bounds = CGRect(x: 0, y: -3, width: 15, height: 15)
        let attstr = NSAttributedString(attachment: attch)
        let mutstr = NSMutableAttributedString(attributedString: attstr)
        return mutstr
    }
    
    public class func attributeString(_ titles:Array<String>,colors:Array<UIColor>,fonts:Array<CGFloat>) -> NSMutableAttributedString{
        let result = NSMutableAttributedString(string: "")
        for i in 0..<titles.count {
            let title = titles[i]
            let color = colors[i]
            let size = fonts[i]
            let str = NSAttributedString(string: title, attributes: [NSForegroundColorAttributeName:color,NSFontAttributeName:UIFont.systemFont(ofSize: size)])
            result.append(str)
        }
        return result
    }
}
