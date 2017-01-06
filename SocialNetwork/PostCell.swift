//
//  PostCell.swift
//  SocialNetwork
//
//  Created by Menan on 2017-01-04.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    
    @IBOutlet weak var captionLabel: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var likeBtnImage: UIImageView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likesCountLabel: UILabel!
    
    func configureCell(post: Posts, img: UIImage? = nil) {
        
        //load the caption
        captionLabel.text = post.caption
 
        //load image 
        if img != nil {
            self.postImage.image = img
        } else {
            
            let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("menan: Error loading data from ref")
                }else {
                    print("menan: Got the data from ref")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImage.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                        }
                    }
                    
                    
                }
            })
        }
        
        
        
        
        
        
        
        
        
        //load likes count
        likesCountLabel.text = "\(post.likes)"
        
    }
}
