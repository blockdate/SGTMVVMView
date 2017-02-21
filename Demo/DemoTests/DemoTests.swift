//
//  DemoTests.swift
//  DemoTests
//
//  Created by 吴磊 on 2017/2/15.
//  Copyright © 2017年 sgt. All rights reserved.
//

import XCTest
import ReactiveCocoa
import ReactiveSwift

@testable import Demo

class DemoTests: XCTestCase {
    
    var nickNameMutableProperty: MutableProperty<String>!
    var nickNameProperty: Property<String>!
    dynamic var nickName: String = ""
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        nickName = "1"
        nickNameProperty = Property(value: nickName)
        nickNameMutableProperty = MutableProperty(nickName)
        
        debugPrint("name init with : \(nickName)")
        nickNameProperty.signal.observeValues { (nickName) in
            debugPrint("nickName changed to \(nickName)")
        }
        nickNameMutableProperty.signal.observeValues { (nickName) in
            debugPrint("nickName changed to \(nickName)")
        }
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        nickName = "2"
        nickNameMutableProperty.value = "2"
    }
    
}
