/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse
import Bolts
import FBSDKCoreKit
import FBSDKLoginKit
import ParseFacebookUtilsV4

class ViewController: UIViewController {   

    @IBAction func loginFacebook(sender: AnyObject) {
        let permissions = ["public_profile", "email"]
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            
            if let error = error {
                print(error)
            } else {
                
                if let user = user {
                    
                    if let interestedInWomen = user["interestedInWomen"] {
                        self.performSegueWithIdentifier("logUserIn", sender: self)
                    } else {
                        self.performSegueWithIdentifier("showSigninScreen", sender: self)
                    }
                    
                    
                }
            }
        } // end block
        print(PFUser.currentUser()?.objectId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        //PFUser.logOut()
        if let username = PFUser.currentUser()?.username {
            if let interestedInWomen = PFUser.currentUser()?["interestedInWomen"] {
                self.performSegueWithIdentifier("logUserIn", sender: self)
            } else {
                self.performSegueWithIdentifier("showSigninScreen", sender: self)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
