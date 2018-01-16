//
//  ChatVC.swift
//  Smack
//
//  Created by Daniel Winship on 1/7/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit

class ChatVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //Oulets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextBox: UITextField!
    @IBOutlet weak var menuButton:UIButton!
    @IBOutlet weak var chatNameLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    
    //Variables
  var isTyping = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        sendButton.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        
        SocketService.instance.getMessage { (success) in
            if success {
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            chatNameLabel.text = "Please Log In"
            tableView.reloadData()
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        chatNameLabel.text = "#\(channelName)"
        getMessages()
    }
    
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        if messageTextBox.text == "" {
            isTyping  = false
            sendButton.isHidden = true
        } else {
            if isTyping == false {
                sendButton.isHidden = false
            }
            isTyping = true
        }
    }
    
    
    @IBAction func sendMsgPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let message = messageTextBox.text else { return }
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success {
                    self.messageTextBox.text = ""
                    self.messageTextBox.resignFirstResponder()
                }
            })
        }
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.chatNameLabel.text = "No channels yet!"
                }
            }
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    
    
    
    
    
    
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//        view.bindToKeyboard()
//        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
//        view.addGestureRecognizer(tap)
//        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
//        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
//
//        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNELS_SELECTED, object: nil)
//
//        if AuthService.instance.isLoggedIn {
//            AuthService.instance.findUserByEmail(completion: { (success) in
//                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
//            })
//        }
//
//    }
//
//    @objc func handleTap() {
//        view.endEditing(true)
//    }
//
//    @IBAction func sendMessagePressed(_ sender: Any) {
//        if AuthService.instance.isLoggedIn {
//            guard let channelId = MessageService.instance.selectedChannel?.id else {return}
//            guard let message = messageTextBox.text else {return}
//
//            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
//                if success {
//                    self.messageTextBox.text = ""
//                    self.messageTextBox.resignFirstResponder()
//                }
//            })
//        }
//    }
//
//
//    @objc func userDataDidChange(_ notif: Notification){
//        if AuthService.instance.isLoggedIn {
//         onLoginGetMessages()
//        } else {
//            chatNameLabel.text = "Please Log In"
//        }
//
//
//    }
//
//    func onLoginGetMessages() {
//        MessageService.instance.findAllChannel { (success) in
//            if success {
//                if MessageService.instance.channels.count > 0 {
//                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
//                    self.updateWithChannel()
//                } else {
//                    self.chatNameLabel.text = "No Channels yet"
//                }
//            }
//        }
//    }
//
//    @objc func channelSelected(_ notif:Notification){
//        updateWithChannel()
//    }
//
//    func updateWithChannel() {
//        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
//        chatNameLabel.text = "#\(channelName)"
//        getMessages()
//    }
//
//    func getMessages() {
//        guard let channelID = MessageService.instance.selectedChannel?.id else {return}
//        MessageService.instance.findAllMessagesForChannel(channelId: channelID) { (success) in
//            if success {
//                print(MessageService.instance.messages)
//                self.tableView.reloadData()
//            }
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
//            let message = MessageService.instance.messages[indexPath.row]
//            cell.configureCell(message: message)
//            return cell
//        } else {
//            return UITableViewCell()
//        }
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//        //return MessageService.instance.messages.count
//    }
    
  
}
