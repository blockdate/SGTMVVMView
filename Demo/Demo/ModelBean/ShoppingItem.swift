//
//  ShoppingItem.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/14.
//  Copyright © 2017年 wleo block. All rights reserved.
//

import UIKit

class ShoppingItem: NSObject {
    dynamic var name: String
    dynamic var price: Double = 0
    dynamic var count: Int = 1
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
}
