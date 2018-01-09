//
//  LoginVC.swift
//  Smack
//
//  Created by Daniel Winship on 1/9/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closedPressed (_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountButtonPressed (_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }

}
