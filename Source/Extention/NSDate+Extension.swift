//
//  NSDate+Extension.swift
//  YiDang-OC
//
//  Created by zmj on 16/6/6.
//  Copyright © 2016年 block. All rights reserved.
//

import Foundation
extension Date {
    public static func currentDate() -> Date{
        let date = Date()
        let zone = TimeZone.current
        let time = zone.secondsFromGMT(for: date)
        return date.addingTimeInterval(Double(time))
    }
}
