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

class ViewController: UIViewController {

    @IBOutlet var username: UITextField!
    @IBOutlet var label: UILabel!
    
    @IBAction func signUp(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(username.text!, password: "password") { (user, error) in
            
            if error != nil {
                
                let user = PFUser()
                user.username = self.username.text!
                user.password = "password"
                
                user.signUpInBackgroundWithBlock({ (succeeded, error) in
                    
                    if let error = error {
                        self.label.text = error.userInfo["error"] as? String
                    } else {
                        print("signed up")
                        self.performSegueWithIdentifier("ShowUserTable", sender: self)
                    }
                    
                })
            
            } else {
                print("Logged In")
                self.performSegueWithIdentifier("ShowUserTable", sender: self)
            }
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = true
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser()?.username != nil {
            performSegueWithIdentifier("ShowUserTable", sender: self)
            //print("Already LoggedIn \(PFUser.currentUser()?.username)")
        }
    }
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
