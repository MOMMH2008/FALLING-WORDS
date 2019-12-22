//
//  View+Extension.swift
//  FALLING WORDS
//
//  Created by Mohamed Helmy on 12/21/19.
//  Copyright © 2019 BABBEL. All rights reserved.
//

import UIKit

@IBDesignable
extension UIView {
    
    // to create rounded corner
    @IBInspectable
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
