//
//  PostCell.swift
//  SocialNetwork
//
//  Created by Menan on 2017-01-04.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    
    @IBOutlet weak var captionLabel: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var likeBtnImage: UIImageView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likesCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
