//
//  ChangeNameVC.swift
//  Smack
//
//  Created by Daniel Winship on 1/17/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit

class ChangeNameVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var changeNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }

    
    @IBAction func closeButtonPressed(_ sender: Any) {
          dismiss(animated: true, completion: nil)
    }
    
    
    func setupView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTapped(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
    }
    
    @objc func closeTapped(_ recognizer:UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        guard let newUserName = changeNameTextField.text else {return}
        AuthService.instance.updateUserName(newUserName: newUserName) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    

}
