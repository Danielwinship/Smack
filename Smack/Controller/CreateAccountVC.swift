//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Daniel Winship on 1/9/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    //outlets
    @IBOutlet weak var usernameText:UITextField!
    @IBOutlet weak var emailText:UITextField!
    @IBOutlet weak var passwordText:UITextField!
    @IBOutlet weak var userImage:UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func closePressed(_ sender:Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    
    }
    
    @IBAction func createAccountPressed(_ sender:Any) {
        guard let email = emailText.text, emailText.text != "" else {return}
        guard let pass = passwordText.text, passwordText.text != "" else {return}
        print("Email: \(email) Password: \(pass)")
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("registered user!")
            }
        }
        
    }
   
    @IBAction func pickedAvatarPressed(_ sender:Any) {
        
    }
    
    @IBAction func pickBGColorPressed(_ sender:Any) {
        
    }

}
