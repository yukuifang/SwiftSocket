//
//  Message.swift
//  KySocketPro
//
//  Created by fangyukui on 2017/11/8.
//  Copyright © 2017年 fangyukui. All rights reserved.
//

import UIKit
import HandyJSON

class Message:HandyJSON {
    var senderId :String?
    var senderDisplayName : String?
    var date : String?
    var text : String?
    var roomName:String?
    var userName : String?
    
    
    init(senderId :String,senderDisplayName : String,date : String,text : String,roomName:String,userName : String) {
        self.senderId = senderId
        self.senderDisplayName = senderDisplayName
        self.date = date
        self.text = text
        self.roomName = roomName
        self.userName = userName
    }
    required init() {
        
    }
    
   
}
