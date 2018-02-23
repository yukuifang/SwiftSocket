//
//  ViewController.swift
//  ChatApp
//
//  Created by fangyukui on 2018/2/22.
//  Copyright © 2018年 fangyukui. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        Alamofire.request(serverUrl).responseData { (res) in
            guard let data = res.data,let result = String(data:data, encoding: .utf8)  else{
                return
            }
            print(result)
            
        }
        
        KySocketClient.shared.connect {
            KySocketClient.shared.defaultSocket.emit("chat", with: ["约吗"])
        }
        KySocketClient.shared.defaultSocket.on("msg") { (data, ack) in
            print("监听到服务器发来的信息:" + "\(data)")
            
        }
        
        
        
        
    }
    @IBAction func toLiving(_ sender: UIButton) {
        //1.创建房间
        let room = Room(roomName: "直播\(sender.tag)")
        KySocketClient.shared.defaultSocket.emit("joinRoom", room.toJSON()!)
        let user = Person(name: "fangyukui")
        user.roomName = room.roomName
        let vc = ChatViewController()
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}



