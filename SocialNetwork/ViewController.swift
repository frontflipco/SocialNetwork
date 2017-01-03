//
//  ViewController.swift
//  SocialNetwork
//
//  Created by Menan on 2017-01-02.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    
    @IBAction func fbLoginPressed(_ sender: Any) {
        
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                print("menan: Error Auth Facebook Login")
            } else if (result?.isCancelled)! {
                print("menan: FB Auth was cancelled by the user")
            } else {
                print("menan: FB Auth was successful")
                let creditionals = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.fireBaseAuth(creditionals: creditionals)
            }
  
        }
        
    }
    
    func fireBaseAuth(creditionals: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: creditionals, completion: { (user, error) in
            if error != nil {
                print("menan: Firebase Auth ERROR")
            }else {
                print("menan: Firebase Auth Successful")
            }
        })
    }


}

