//
//  AvatarCell.swift
//  Smack
//
//  Created by Daniel Winship on 1/10/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
 
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    
    func setupView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
    }
    

}
