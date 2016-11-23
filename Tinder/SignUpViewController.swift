//
//  SignUpViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Luís Machado on 22/07/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4

class SignUpViewController: UIViewController {

    @IBAction func signUp(sender: AnyObject) {
        
        PFUser.currentUser()?["interestedInWomen"] = interestedInWomen.on
        do {
            try PFUser.currentUser()?.save()
        } catch {
            print("There was a problem!")
        }
        
        
    }
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var interestedInWomen: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, name, gender, email"])
        graphRequest.startWithCompletionHandler { (connection, result, error) in
            
            if error != nil {
                print(error)
            } else if let result = result {
                //print(result)
            
                PFUser.currentUser()?["gender"] = result["gender"]!
                PFUser.currentUser()?["name"] = result["name"]!
                PFUser.currentUser()?["email"] = result["email"]!
                
                do {
                    try PFUser.currentUser()?.save()
                } catch {
                    print("There was a problem!")
                }
                
                let userId = result["id"]! as! String
                let facebookProfilePictureUrl = "https://graph.facebook.com/" + userId + "/picture?type=large"
                
                if let fbpicUrl = NSURL(string: facebookProfilePictureUrl) {
                    
                    if let data = NSData(contentsOfURL: fbpicUrl) {
                        
                        self.userImage.image = UIImage(data: data)
                        
                        let imageFile:PFFile = PFFile(data: data)!
                        PFUser.currentUser()?["image"] = imageFile
                        
                        do {
                            try PFUser.currentUser()?.save()
                        } catch {
                            print("There was a problem!")
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
