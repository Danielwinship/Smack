//
//  RoundedButton.swift
//  Smack
//
//  Created by Daniel Winship on 1/10/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {


    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    override func awakeFromNib() {
        self.setupView()
    }

    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }


}
