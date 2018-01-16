//
//  SocketService.swift
//  Smack
//
//  Created by Daniel Winship on 1/15/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit
import SocketIO

 var manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
var socket = manager.defaultSocket

class SocketService: NSObject {
    
    static let instance = SocketService()
    

    
    override init() {
        super.init()
    }
    
   
    

    func establishConnection() {
       socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(name: String, description: String, completion: @escaping CompletionHandler) {
        socket.emit(SOCKET_EVT_NEW_CHANNEL, name, description)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        MessageService.instance.clearChannels()
       socket.on(SOCKET_EVT_CHANNEL_CREATED) { (dataArray, ack) in
            guard let name = dataArray[0] as? String else { return }
            guard let description = dataArray[1] as? String else { return }
            guard let id = dataArray[2] as? String else { return }
            let newChannel = Channel(channelTitle: name, channelDescription: description, id: id)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    
  
    
    func addMessage(messageBody:String, userId:String, channelId:String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody,userId,channelId, user.name,user.avatarName,user.avatarColor)
        completion(true)
    }
    
    func getMessage(completion: @escaping CompletionHandler) {
        socket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let userAvatarColor = dataArray[5] as? String else {return}
            guard let id = dataArray[6] as? String else {return}
            guard let timeStamp = dataArray[7] as? String else {return}
            
            if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                
                let newMessage = Message(message: msgBody, userName: userName, channelID: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                MessageService.instance.messages.append(newMessage)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    
    
    
    func getTypingUsers(_ completionHandler: @escaping (_ typingUsers: [String: String]) -> Void) {
        
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String: String] else { return }
            completionHandler(typingUsers)
        }
        
    }
    

    
    func startTyping() {
              guard let channelId = MessageService.instance.selectedChannel?.id else {return}
    socket.emit("startType", UserDataService.instance.name, channelId)
    }
    
    func stopTyping() {
          guard let channelId = MessageService.instance.selectedChannel?.id else {return}
        socket.emit("stopType", UserDataService.instance.name, channelId)
    }
    
    
    
    
    
    
    
    
    
    
    

}
