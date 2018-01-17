//
//  MessageCell.swift
//  Smack
//
//  Created by Daniel Winship on 1/15/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    //outlets
    
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var messageBodyLabel: UILabel!
    @IBOutlet weak var timeStampeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(message: Message) {
        messageBodyLabel.text = message.message
        userNameLabel.text = message.userName
        userImage.image = UIImage(named: message.userAvatar)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        
        guard var isoDate = message.timeStamp else { return }
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStampeLabel.text = finalDate
        }
    }
}
