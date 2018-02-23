//
//  Room.swift
//  KySocketPro
//
//  Created by fangyukui on 2017/11/8.
//  Copyright © 2017年 fangyukui. All rights reserved.
//

import UIKit
import HandyJSON

class Room:HandyJSON {
    var roomName : String?
    var roomId :String?
    init(roomName:String) {
        self.roomName = roomName
        self.roomId = roomName + "\(arc4random())"
    }
    required init() {
        
    }
}
