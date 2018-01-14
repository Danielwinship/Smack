//
//  AddChannelVC.swift
//  Smack
//
//  Created by Daniel Winship on 1/14/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    
    //outlets
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var chanDesc: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var createChannelPressed: RoundedButton!
    
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        nameText.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
        
        
        chanDesc.attributedPlaceholder = NSAttributedString(string: "Description", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
    }
    
    @objc func closeTap(_ regcognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
