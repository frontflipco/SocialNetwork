//
//  ShawdowView.swift
//  SocialNetwork
//
//  Created by Menan on 2017-01-03.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit

class ShawdowView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: SHADOW_GREY).cgColor
        layer.shadowRadius = 0
        layer.shadowOpacity = 5.0
        layer.shadowOffset = CGSize(width: 1, height: 1)
        
    }

}
