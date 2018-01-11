//
//  ProfileVC.swift
//  Smack
//
//  Created by Daniel Winship on 1/11/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileImage:UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }

   
 
    func setupView() {
       profileImage.image = UIImage(named: UserDataService.instance.avatarName)
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        profileImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTapped(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
    }
    
    @objc func closeTapped(_ recognizer:UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

}
