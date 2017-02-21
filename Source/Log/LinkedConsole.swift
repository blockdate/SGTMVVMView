//
//  LinkedConsole.swift
//  YiDang-Shop
//
//  Created by 磊吴 on 16/1/7.
//  Copyright © 2016年 block. All rights reserved.
//

import Foundation
import CocoaLumberjack.DDDispatchQueueLogFormatter

open class KZFormatter: DDDispatchQueueLogFormatter {
    
    open lazy var formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.formatterBehavior = .behavior10_4
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        return dateFormatter
    }()
    
    open override func format(message logMessage: DDLogMessage!) -> String {
        let dateAndTime = formatter.string(from: logMessage.timestamp)
        
        var logLevel: String
        let logFlag = logMessage.flag
        if logFlag.contains(.error) {
            logLevel = "❌ERR❌"
        } else if logFlag.contains(.warning){
            logLevel = "⚠️WRN⚠️"
        } else if logFlag.contains(.info) {
            logLevel = "INF"
        } else if logFlag.contains(.debug) {
            logLevel = "💚DBG💚"
        } else if logFlag.contains(.verbose) {
            logLevel = "💢VRB💢"
        } else {
            logLevel = "⁉️???⁉️"
        }
        
        let formattedLog = "\(dateAndTime) |\(logLevel)| \((logMessage.file as NSString).lastPathComponent):\(logMessage.line): ( \(logMessage.function ?? "") ): \(logMessage.message ?? "")"
        return formattedLog;
    }
}
