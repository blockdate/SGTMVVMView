//
//  SGTReactViewLog.swift
//  SGTReactView
//
//  Created by 吴磊 on 2016/10/8.
//  Copyright © 2016年 wleo. All rights reserved.
//

import Foundation
import CocoaLumberjack

internal func SGTLogDebug(_ logText: @autoclosure () -> String, level: DDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: AnyObject? = nil, asynchronous async: Bool = true) {
    if SGTReactViewConfig.logEnableLevel.contains(.debug) {
        SwiftLogMacro(async, level: level, flag: .debug, context: context, file: file, function: function, line: line, tag: tag, string: logText)
    }
}

internal func SGTLogInfo(_ logText: @autoclosure () -> String, level: DDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: AnyObject? = nil, asynchronous async: Bool = true) {
    if SGTReactViewConfig.logEnableLevel.contains(.info) {
        SwiftLogMacro(async, level: level, flag: .info, context: context, file: file, function: function, line: line, tag: tag, string: logText)
    }
}

internal func SGTLogWarn(_ logText: @autoclosure () -> String, level: DDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: AnyObject? = nil, asynchronous async: Bool = true) {
    if SGTReactViewConfig.logEnableLevel.contains(.warning) {
        SwiftLogMacro(async, level: level, flag: .warning, context: context, file: file, function: function, line: line, tag: tag, string: logText)
    }
}

internal func SGTLogVerbose(_ logText: @autoclosure () -> String, level: DDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: AnyObject? = nil, asynchronous async: Bool = true) {
    if SGTReactViewConfig.logEnableLevel.contains(.verbose) {
        SwiftLogMacro(async, level: level, flag: .verbose, context: context, file: file, function: function, line: line, tag: tag, string: logText)
    }
}

internal func SGTLogError(_ logText: @autoclosure () -> String, level: DDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: AnyObject? = nil, asynchronous async: Bool = false) {
    if SGTReactViewConfig.logEnableLevel.contains(.error) {
        SwiftLogMacro(async, level: level, flag: .error, context: context, file: file, function: function, line: line, tag: tag, string: logText)
    }
}
