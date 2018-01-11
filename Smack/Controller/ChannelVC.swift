//
//  ChannelVC.swift
//  Smack
//
//  Created by Daniel Winship on 1/7/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
     @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    //Outlet
    @IBOutlet weak var loginButton:UIButton!
    @IBOutlet weak var userImage:UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)

    }

    @IBAction func loginButtonPressed(_ sender:Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
   @objc func userDataDidChange(_ notif: Notification){
    if AuthService.instance.isLoggedIn {
        loginButton.setTitle(UserDataService.instance.name, for: .normal)
        userImage.image = UIImage(named: UserDataService.instance.avatarName)
    } else {
        loginButton.setTitle("Login", for: .normal)
        userImage.image = UIImage(named: "menuProfileIcon")
        userImage.backgroundColor = UIColor.clear
        
    }
  }

}
