//
//  FeedVC.swift
//  SocialNetwork
//
//  Created by Menan on 2017-01-03.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func logOffPressed(_ sender: UIButton) {
        
        if let removeSuccessful: Bool = KeychainWrapper.standard.remove(key: KEY_UID) {
            print("menan: UID removed from keychain \(removeSuccessful)")
            performSegue(withIdentifier: GoToLogin, sender: nil)
        }

    }
}
