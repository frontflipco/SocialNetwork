//
//  FeedVC.swift
//  SocialNetwork
//
//  Created by Menan on 2017-01-03.
//  Copyright © 2017 Frontflip. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //Outlets
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Posts]()
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    static var imageCache: NSCache <NSString, UIImage> = NSCache()
    
    
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var captionField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        print("menan:Got here")

        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        DataService.ds.DATABASE_BASE_POSTS.observe(.value, with: { (snapshot) in
            print("menan:\(snapshot.value!)")
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    if let postData = snap.value as? Dictionary <String, AnyObject> {
                        let key = snap.key
                        let post = Posts(postKey: key, postData: postData)
                        print("menan: \(postData)")
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            
            print("got here 2")
            
            if let img = FeedVC.imageCache.object(forKey: posts[indexPath.row].imageUrl as NSString) {
                print("menan:Got the cache")
                cell.configureCell(post: posts[indexPath.row], img: img)
                return cell
            } else {
                print("menan:Got the noncache")
                cell.configureCell(post: posts[indexPath.row])
                return cell
            }
           
        }
        
        
        print("menan:Got nothing")
        
        return PostCell()

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageSelected = true
            addImage.image = image
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func logOffPressed(_ sender: UIButton) {
        
        if let removeSuccessful: Bool = KeychainWrapper.standard.remove(key: KEY_UID) {
            print("menan: UID removed from keychain \(removeSuccessful)")
            performSegue(withIdentifier: GoToLogin, sender: nil)
        }

    }


    @IBAction func addImagePressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
        
    }

    @IBAction func postBtnPressed(_ sender: Any) {
        
        if imageSelected{
            if let img = addImage.image {
                if (captionField.text) != nil {
                    let formattedImage = UIImageJPEGRepresentation(img, 0.2)
                    let imgId = NSUUID().uuidString
                    let metaData = FIRStorageMetadata()
                    metaData.contentType = "image/jpeg"
                    DataService.ds.STORAGE_BASE_IMAGES.child(imgId).put(formattedImage!, metadata: metaData) {(metaData, error) in
                        if error != nil {
                            print("menan: error uploading image")
                        } else {
                            print("menan: image uploaded")
                            let downloadUrl = metaData?.downloadURL()?.absoluteString
                            if let url = downloadUrl {
                                self.updatePostToFirebase(url: url)
                            }
                        }
                    
                    }
                
                    
                
                }
            }
        }
        
        
    }

    func updatePostToFirebase(url: String) {
        
        let post: Dictionary<String, Any> = [
        "imageUrl": url ,
        "caption" : captionField.text,
        "likes" : 0
        ]

        let ref = DataService.ds.DATABASE_BASE_POSTS.childByAutoId().setValue(post)
        print("menan: updated to firebase")
        
        captionField.text = ""
        addImage.image = UIImage(named: "add-image")
        
    }
    
    
    

}
