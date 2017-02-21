// Software License Agreement (BSD License)
//
// Copyright (c) 2014-2015, Deusty, LLC
// All rights reserved.
//
// Redistribution and use of this software in source and binary forms,
// with or without modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
//
// * Neither the name of Deusty nor the names of its contributors may be used
//   to endorse or promote products derived from this software without specific
//   prior written permission of Deusty, LLC.

import Foundation
import CocoaLumberjack

extension DDLogFlag {
    public static func fromLogLevel(_ logLevel: DDLogLevel) -> DDLogFlag {
        return DDLogFlag(rawValue: logLevel.rawValue)
    }
	
	public init(_ logLevel: DDLogLevel) {
        self = DDLogFlag(rawValue: logLevel.rawValue)
	}
    
    ///returns the log level, or the lowest equivalant.
    public func toLogLevel() -> DDLogLevel {
        if let ourValid = DDLogLevel(rawValue: self.rawValue) {
            return ourValid
        } else {
            let logFlag:DDLogFlag = self
            
            if logFlag.contains(.verbose) {
                return .verbose
            } else if logFlag.contains(.debug) {
                return .debug
            } else if logFlag.contains(.info) {
                return .info
            } else if logFlag.contains(.warning) {
                return .warning
            } else if logFlag.contains(.error) {
                return .error
            } else {
                return .off
            }
        }
    }
}

public var defaultDebugLevel = DDLogLevel.verbose

public func resetDefaultDebugLevel() {
    defaultDebugLevel = DDLogLevel.verbose
}

public func SwiftLogMacro(_ isAsynchronous: Bool, level: DDLogLevel, flag flg: DDLogFlag, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: AnyObject? = nil, string: @autoclosure () -> String) {
    if level.rawValue & flg.rawValue != 0 {
        // Tell the DDLogMessage constructor to copy the C strings that get passed to it.
        // Using string interpolation to prevent integer overflow warning when using StaticString.stringValue
        let logMessage = DDLogMessage(message: string(), level: level, flag: flg, context: context, file: "\(file)", function: "\(function)", line: line, tag: tag, options: [.copyFile, .copyFunction], timestamp: nil)
        DDLog.log(asynchronous: isAsynchronous, message: logMessage)
    }
}

public func DDLogDebug(_ logText: @autoclosure () -> String, level: DDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: AnyObject? = nil, asynchronous async: Bool = true) {
    SwiftLogMacro(async, level: level, flag: .debug, context: context, file: file, function: function, line: line, tag: tag, string: logText)
}

public func DDLogInfo(_ logText: @autoclosure () -> String, level: DDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: AnyObject? = nil, asynchronous async: Bool = true) {
    SwiftLogMacro(async, level: level, flag: .info, context: context, file: file, function: function, line: line, tag: tag, string: logText)
}

public func DDLogWarn(_ logText: @autoclosure () -> String, level: DDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: AnyObject? = nil, asynchronous async: Bool = true) {
    SwiftLogMacro(async, level: level, flag: .warning, context: context, file: file, function: function, line: line, tag: tag, string: logText)
}

public func DDLogVerbose(_ logText: @autoclosure () -> String, level: DDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: AnyObject? = nil, asynchronous async: Bool = true) {
    SwiftLogMacro(async, level: level, flag: .verbose, context: context, file: file, function: function, line: line, tag: tag, string: logText)
}

public func DDLogError(_ logText: @autoclosure () -> String, level: DDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: AnyObject? = nil, asynchronous async: Bool = false) {
    SwiftLogMacro(async, level: level, flag: .error, context: context, file: file, function: function, line: line, tag: tag, string: logText)
}

/// Analogous to the C preprocessor macro `THIS_FILE`.
public func CurrentFileName(_ fileName: StaticString = #file) -> String {
    // Using string interpolation to prevent integer overflow warning when using StaticString.stringValue
    // This double-casting to NSString is necessary as changes to how Swift handles NSPathUtilities requres the string to be an NSString
    return (("\(fileName)" as NSString).lastPathComponent as NSString).deletingPathExtension
}
