//
//  RoundButton.swift
//  SocialNetwork
//
//  Created by Menan on 2017-01-03.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView?.contentMode = .scaleAspectFit
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width / 2
    }

}
