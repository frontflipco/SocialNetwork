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
    
    var post: Posts!
    
    var likesRef: FIRDatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likePressed))
        tap.numberOfTapsRequired = 1
        likeBtnImage.addGestureRecognizer(tap)
        likeBtnImage.isUserInteractionEnabled = true
    }
    
    func configureCell(post: Posts, img: UIImage? = nil) {
        
        self.post = post
        self.likesRef = DataService.ds._DATABASE_USER.child("likes").child(post.postKey)

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
        
        
        self.likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeBtnImage.image = UIImage(named: "empty-heart")
            } else {
                self.likeBtnImage.image = UIImage(named: "filled-heart")
                
            }
        })
        

       
        //load likes count
        likesCountLabel.text = "\(post.likes)"
        
    }
    
    func likePressed(sender: UITapGestureRecognizer) {
        self.likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeBtnImage.image = UIImage(named: "filled-heart")
                self.post.adjustLikes(add: true)
                self.likesRef.setValue(true)
            } else {
                self.likeBtnImage.image = UIImage(named: "empty-heart")
                self.post.adjustLikes(add: false)
                self.likesRef.removeValue()
            }
        })
        
        
    }
}
