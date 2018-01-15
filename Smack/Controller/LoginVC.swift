//
//  LoginVC.swift
//  Smack
//
//  Created by Daniel Winship on 1/9/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    //outlets
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        
    }

    @IBAction func loginPressed(_ sender: Any) {
      spinner.isHidden = false
      spinner.startAnimating()
      
        guard let email = usernameText.text , usernameText.text != "" else {return}
        guard let password = passwordText.text, passwordText.text != "" else {return}
        
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
        
        
    }
    @IBAction func closedPressed (_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountButtonPressed (_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
  func setupView(){
    spinner.isHidden = true
     usernameText.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
     passwordText.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
    
    
    }
    

}
