//
//  DataService.swift
//  SocialNetwork
//
//  Created by Menan on 2017-01-04.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DATABASE_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    static var ds = DataService()
    
    private let _DATABASE_BASE = DATABASE_BASE
    private let _DATABASE_BASE_USERS = DATABASE_BASE.child("users")
    private let _DATABASE_BASE_POSTS = DATABASE_BASE.child("posts")
    private let _STORAGE_BASE_IMAGES = STORAGE_BASE.child("postImages")
    
    var REF_DATABASE_BASE: FIRDatabaseReference {
        return _DATABASE_BASE
    }
    
    var DATABASE_BASE_USERS: FIRDatabaseReference {
        return _DATABASE_BASE_USERS
    }
    
    var DATABASE_BASE_POSTS: FIRDatabaseReference {
        return _DATABASE_BASE_POSTS
    }
    
    var _DATABASE_USER: FIRDatabaseReference {
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = self._DATABASE_BASE_USERS.child(retrievedString!)
            return user
        
    }
    
    
    var STORAGE_BASE_IMAGES: FIRStorageReference {
        return _STORAGE_BASE_IMAGES
    }
    
    func createNewUserInDatabase(uid: String, userData: Dictionary<String,String>) {
        DATABASE_BASE_USERS.child(uid).updateChildValues(userData)
    }
}
