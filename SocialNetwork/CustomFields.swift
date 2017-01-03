//
//  CustomFields.swift
//  SocialNetwork
//
//  Created by Menan on 2017-01-03.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit

class CustomFields: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: SHADOW_GREY).cgColor
        layer.borderWidth = 3
        layer.cornerRadius = 2
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.insetBy(dx: 10, dy: 5)
    }
}
