//
//  Posts.swift
//  SocialNetwork
//
//  Created by Menan on 2017-01-04.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import Foundation

class Posts {
    
    
    private var _caption: String!
    private var _imageUrl: String!
    private var _likes: Int!
    private var _postKey: String!
    
    var caption: String {
        return _caption
    }
    var imageUrl: String {
        return _imageUrl
    }
    var likes: Int {
        return _likes
    }
    var postKey: String {
        return _postKey
    }
    
    init(caption: String, imageUrl: String, likes: Int, postKey: String) {
        
        self._caption = caption
        self._imageUrl = imageUrl
        self._likes = likes
        self._postKey = postKey
        
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String {
            self._caption = caption
        }
        
        if let imageUrl = postData["imageUrl"] as? String {
            self._imageUrl = imageUrl
        }
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
    }
    
    func adjustLikes(add: Bool) {
        if add {
            _likes = _likes + 1
        }else {
            _likes = _likes - 1
        }
        let postRef = DataService.ds.DATABASE_BASE_POSTS.child(self._postKey).child("likes")
        postRef.setValue(_likes)
    }
}
