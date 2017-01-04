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
import SwiftKeychainWrapper

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: GoToFeed, sender: nil)
        }
    } 
    @IBOutlet weak var emailField: CustomFields!

    @IBOutlet weak var passwordField: CustomFields!

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
                if let user = user {
                    self.addToKeyChain(id: user.uid)
                }
            }
        })
    }
    
    
    @IBAction func signInPressed(_ sender: UIButton) {
        
        if let email = emailField.text, let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("menan: login with email is successful")
                    if let user = user {
                        self.addToKeyChain(id: user.uid)
                    }
                    
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error == nil {
                            print("menan: email user has been created")
                            if let user = user {
                                self.addToKeyChain(id: user.uid)
                            }
                        } else {
                            print("menan: error while creating a user")
                        }
                        
                    })
                }
            })
            
        }
    }
    
    func addToKeyChain(id: String) {
        let saveSuccessful: Bool = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("menan: Saved UID succesfully \(saveSuccessful)")
        performSegue(withIdentifier: GoToFeed, sender: nil)
    }
}

