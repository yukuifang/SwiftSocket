//
//  ChatViewController.swift
//  KySocketPro
//
//  Created by fangyukui on 2017/11/7.
//  Copyright © 2017年 fangyukui. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import HandyJSON

class ChatViewController: JSQMessagesViewController {
    public var user : Person?
    
    fileprivate var messages = [JSQMessage]()
    
    fileprivate let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor(red: 10/255, green: 180/255, blue: 230/255, alpha: 1.0))
    
    fileprivate let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with:.lightGray)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addMessage()
        KySocketClient.shared.defaultSocket.on("msg") { (data, ack) in
             print("监听到服务器发来的信息:" + "\(data)")
            let message = JSQMessage(senderId: "Server", displayName: "Server", text: "\(data)")
            self.messages.append(message!)
            self.finishSendingMessage()
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        KySocketClient.shared.defaultSocket.emit("leaveRoom", (user?.roomName)!)
    }

}
extension ChatViewController{
    
    func addMessage() {
        var messages = ["马云大哥好！","老表好！","今年先赚他一个亿","一个月赚10亿很难受","滚"]
        for i in 0..<messages.count{
            let sender = (i%2 == 0) ? "Server" : self.senderId
            let messageContent = messages[i]
            let message = JSQMessage(senderId: sender, displayName: sender, text: messageContent)
            self.messages.append(message!)
        }
        self.reloadMessagesView()
    }
    func setup() {
       self.senderId  =  UIDevice.current.identifierForVendor?.uuidString
       self.senderDisplayName  =  UIDevice.current.identifierForVendor?.uuidString
     
    }
    func reloadMessagesView() {
        self.collectionView?.reloadData()
    }

}

extension ChatViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        
        let data = self.messages[indexPath.row]
        return data
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didDeleteMessageAt indexPath: IndexPath!) {
        self.messages.remove(at: indexPath.row)
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let data = messages[indexPath.row]
        switch(data.senderId) {
            case self.senderId:
                return self.outgoingBubble
            default:
                return self.incomingBubble
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        let data = messages[indexPath.row]
        var img:UIImage
        
        if data.senderId == senderId{
            img =  UIImage(named: "1")!
        }else{
            img =  UIImage(named: "2")!
        }
        
        return JSQMessagesAvatarImage(avatarImage: img, highlightedImage: img, placeholderImage: img)
    }
    
    
}
//MARK - Toolbar
extension ChatViewController {
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        if KySocketClient.shared.isConnected{
            // 1
            let msg = Message(senderId: senderId, senderDisplayName: senderDisplayName, date: date.description, text: text,roomName:(user?.roomName)!,userName:(user?.name)!).toJSON()
            KySocketClient.shared.defaultSocket.emit("chat", msg!)
            
            
            // 2
            let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
            self.messages.append(message!)
            self.finishSendingMessage()
        }else{
            print("发送信息到服务器失败。。。")
        }
        
    }

    override func didPressAccessoryButton(_ sender: UIButton!) {
        
    }
}
