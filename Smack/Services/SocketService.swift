//
//  SocketService.swift
//  Smack
//
//  Created by Daniel Winship on 1/15/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit
import SocketIO

let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
let socket = manager.defaultSocket

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
    
    
    

}
