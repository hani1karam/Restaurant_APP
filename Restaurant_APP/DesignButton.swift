//
//  DesignButton.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 7/31/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

@IBDesignable class DesignButton: UIButton {
    
    @IBInspectable var roundCorner : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = roundCorner
        }
    }
    @IBInspectable var BorderColor : UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    @IBInspectable var BorderWidth : CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = BorderWidth
        }
    }
}
