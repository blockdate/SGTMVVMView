//
//  GlobalDefine.swift
//  EasyPawnShop
//
//  Created by 磊吴 on 15/10/13.
//  Copyright © 2015年 block. All rights reserved.
//

import Foundation
import UIKit
//public struct SGTRSAEncryptKey {
//    public static let publicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCh7+u5FKHwDc/FZq4LCpfsuwa8eqDzsl++Bz5Z9fPi2Tar3exoN8xBRsT/XFsDX17xBm8JojGyzMZ5aBAS2mQMogq/gpj3Yd2b1XtmEHBlNbIb09SHJHtx5ojlIHUG6nPIMW9KphtDtoZE24B/3XzzAXA3NgTLbuhC+nAtSz7xqQIDAQAB"
//    
//    public static let privateKey = "MIICeQIBADANBgkqhkiG9w0BAQEFAASCAmMwggJfAgEAAoGBAKHv67kUofANz8VmrgsKl+y7Brx6oPOyX74HPln18+LZNqvd7Gg3zEFGxP9cWwNfXvEGbwmiMbLMxnloEBLaZAyiCr+CmPdh3ZvVe2YQcGU1shvT1Icke3HmiOUgdQbqc8gxb0qmG0O2hkTbgH/dfPMBcDc2BMtu6EL6cC1LPvGpAgMBAAECgYEAjJN2Ekky+u1CfJ7SX4tmr378LgpWRreGHbS0D+xPN5JQv4n7e81UZyZERVmrOJZGGP34zmgatJjHgwUvTu5/AoayY1sHXIp7JmQzqa8qvZghTXoeNpnqXbj8sS6HEY5itE1mZOtwOE8HcykMZGaXodGZz1f7NysCyAZWpnJkEcECQQDTu9qYR3kdij89+VsCAT2x7qDrirraUPs0PNnvXbJ1WWgtikCBs6foKKprYs8nXYs2xfDfKn/Xdp8DkoAJsmGNAkEAw8rqiulMgmM7ntw+6rRI/3nNiyBzdsf06JI66SFD1nn94lUXTypOG5Ue0YdWhd3+wwkEb9LmyX2Ky/G5YfjTjQJBALDtzSBquT6CA47aC76FIvTInxe0eads/D0OjF6FQVbmOzOyz2ySn8BUGvRZQRl4BZjjlwAlF2cI7J+jj/KKaRECQQC+9LMX1D4olPvbDlfWtQrVEEilvnqeiJqWEbifEzCEh+pTykW3kj0nraKnHGYIneEQ+0R2g61PKsAp9JGnufUpAkEApR8F3F6Kf5NK78xJOS7cbZ1UzdiuABncl8Hnzkb+QaD1d/o3IBHFwqSwhWNvA8JjInZoWsetLUaKvznZezAi+Q=="
//}

public struct SGTNotificationCenterName {
    public static let netStatue = "SGTNotificationCenterName.netStatue"
}

/// user interface
public struct SGTUtilUserInterfaceIdiom {
    /// The user interface should be designed for iPhone and iPod touch.
    public static let isPhone = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    /// The user interface should be designed for iPad.
    public static let isPad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    /// The user interface should be designed for Apple TV.
    //    static let isAppleTv = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.TV
    
}


/// 屏幕尺寸
public struct SGTUtilScreenSize {
    
    public static func heightFitToScreen(_ height:CGFloat) ->CGFloat {
        return CGFloat(height * SGTUtilScreenSize.screenHeightScale)
    }
    public static func widthFitToScreen(_ width:CGFloat) ->CGFloat {
        return CGFloat(width * SGTUtilScreenSize.screenWidthScale)
    }
    
    public static let screen5SWidth:CGFloat = 320.0
    public static let screen5SHeight:CGFloat = 568.0
    public static let screenWidthScale = SGTUtilScreenSize.screenWidth/SGTUtilScreenSize.screen5SWidth
    public static let screenHeightScale = SGTUtilScreenSize.screenHeight/SGTUtilScreenSize.screen5SHeight
    /// 屏幕宽
    public static let screenWidth = UIScreen.main.bounds.size.width
    /// 屏幕高
    public static let screenHeight = UIScreen.main.bounds.size.height
    /// 屏幕最大长度
    public static let screenMaxLength = max(SGTUtilScreenSize.screenWidth, SGTUtilScreenSize.screenHeight)
    /// 屏幕最小长度
    public static let screenMinLength = min(SGTUtilScreenSize.screenMaxLength, SGTUtilScreenSize.screenHeight)
    
}

public struct SGTTextFont {
    public static var small = UIFont.systemFont(ofSize: SGTTextSize.small)
    public static var contentNormal = UIFont.systemFont(ofSize: SGTTextSize.contentNormal)
    public static var titleMini = UIFont.systemFont(ofSize: SGTTextSize.titleMini)
    public static var title = UIFont.systemFont(ofSize: SGTTextSize.title)
    public static var large = UIFont.systemFont(ofSize: SGTTextSize.large)
    public static var huge = UIFont.systemFont(ofSize: SGTTextSize.huge)
}

public struct SGTTextSize {
    public static var small: CGFloat = 10.0+2*level
    public static var contentNormal: CGFloat = 13.0+2*level
    public static var titleMini: CGFloat = 15.0+2*level
    public static var title: CGFloat = 17.0+2*level
    public static var large: CGFloat = 16.0+2*level
    public static var huge: CGFloat = 18.0+2*level
    
    fileprivate static var level : CGFloat {
        if SGTUtilDeviceType.isIPhone4 {
            return 0
        }else if SGTUtilDeviceType.isIPhone5 {
            return 1
        }else if SGTUtilDeviceType.isIPhone6 {
            return 1.5
        }else if SGTUtilDeviceType.isIPhone6P {
            return 2
        }else {
            return 1.5
        }
    }
}

public struct SGTDefaultImage {
    public static func placeHolder() -> UIImage {
        return UIImage(named: "default_Image") ?? UIImage()
    }
}

/// 机型
public struct SGTUtilDeviceType {
    
    /// IPhone4
    public static let isIPhone4 = SGTUtilUserInterfaceIdiom.isPhone && SGTUtilScreenSize.screenMaxLength == 480.0
    /// IPhone5
    public static let isIPhone5 = SGTUtilUserInterfaceIdiom.isPhone && SGTUtilScreenSize.screenMaxLength == 568.0
    /// IPhone6
    public static let isIPhone6 = SGTUtilUserInterfaceIdiom.isPhone && SGTUtilScreenSize.screenMaxLength == 667.0
    /// IPhone6P
    public static let isIPhone6P = SGTUtilUserInterfaceIdiom.isPhone && SGTUtilScreenSize.screenMaxLength == 736.0
    
}

public struct SGTColor {
    public static var red = UIColor ( red: 218.5/255.0, green: 34.9/255.0, blue: 40.8/255.0, alpha: 1.0 )
    public static var system = UIColor ( red: 236/255.0, green: 105/255.0, blue: 65/255.0, alpha: 1.0 )
    public static var background = UIColor ( red: 0.9373, green: 0.9529, blue: 0.9647, alpha: 1.0 )
    public static var redbackground = UIColor ( red: 0.9903, green: 0.996, blue: 0.9704, alpha: 1.0 )
    public static var line = UIColor ( red: 0.8304, green: 0.8304, blue: 0.8304, alpha: 1.0 )
    public static var title = UIColor ( red: 0.0815, green: 0.0815, blue: 0.0815, alpha: 1.0 )
    public static var subtitle = UIColor ( red: 0.5843, green: 0.5843, blue: 0.5843, alpha: 1.0 )
    public static var navtitle = UIColor ( red: 0.0815, green: 0.0815, blue: 0.0815, alpha: 1.0 )
    public static var lightGray = UIColor ( red: 0.5843, green: 0.5843, blue: 0.5843, alpha: 1.0 )
    public static var dark = UIColor ( red: 0.0815, green: 0.0815, blue: 0.0815, alpha: 1.0 )
    public static var navbackground = UIColor ( red: 0.9373, green: 0.9529, blue: 0.9647, alpha: 1.0 )
    public static var price = UIColor ( red: 0.8965, green: 0.3224, blue: 0.1982, alpha: 1.0 )
}

public struct SGTSearchNotification {
    /// 重置CategorySearchViewController/ListSearchViewController.keyWord和viewModel.page
    public  static let SearchHistoryCellDidSelectedNotification:String = "SearchHistoryCellDidSelectedNotification"
    
}



