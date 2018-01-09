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
    

    override func viewDidLoad() {
        super.viewDidLoad()
self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60

    }

    @IBAction func loginButtonPressed(_ sender:Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }

}
