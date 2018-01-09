//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Daniel Winship on 1/9/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func closePressed(_ sender:Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    
    }
   

}
