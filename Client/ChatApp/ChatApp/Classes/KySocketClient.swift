//
//  KySocketClient.swift
//  KySocketPro
//
//  Created by fangyukui on 2017/11/8.
//  Copyright © 2017年 fangyukui. All rights reserved.
//

import UIKit

import SocketIO

class KySocketClient: SocketManager {
    static let shared : KySocketClient = KySocketClient(socketURL: URL(string: serverUrl)!, config:[.log(true), .compress])
    
    private(set) var isConnected  = false
    
    
    func connect(sucess:@escaping ()->()) {
        //TCP三次握手(第一步)
        self.connect()
        
        ///TCP三次握手(第二步发生在服务器)
        
        //TCP三次握手(第三步)
        self.defaultSocket.on(clientEvent: .connect) { (data, ack) in
            print("成功与服务器建立连接。。。")
            self.isConnected = true
            sucess()
            
        }
    }

}
