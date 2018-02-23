//
//  Person.swift
//  KySocketPro
//
//  Created by fangyukui on 2017/11/7.
//  Copyright © 2017年 fangyukui. All rights reserved.
//

import UIKit

class Person{
    var name : String
    var pId : String
    var roomName : String?
    
    init(name:String) {
        self.name = name
        self.pId = name + "\(arc4random())"
    }
    
    
    
}
