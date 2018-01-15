//
//  ChatVC.swift
//  Smack
//
//  Created by Daniel Winship on 1/7/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    //Oulets
    @IBOutlet weak var menuButton:UIButton!
    @IBOutlet weak var chatNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNELS_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
        MessageService.instance.findAllChannel { (success) in
            
        }
    }
    
    
    @objc func userDataDidChange(_ notif: Notification){
        if AuthService.instance.isLoggedIn {
         onLoginGetMessages()
        } else {
            chatNameLabel.text = "Please Log In"
        }
        
        
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                //do stuff with channels
            }
        }
    }
    
    @objc func channelSelected(_ notif:Notification){
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        chatNameLabel.text = "#\(channelName)"
    }
    

  
}
