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
    

    

}
