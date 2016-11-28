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

class ViewController: UIViewController, UITextFieldDelegate {
    
    var signUpState = true

    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!    
    @IBOutlet var `switch`: UISwitch!
    @IBOutlet var riderLabel: UILabel!
    @IBOutlet var driverlabel: UILabel!
    
    
    func displayAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func signUp(sender: AnyObject) {
        
        if username.text == "" || password.text == "" {
            displayAlert("Missing Fields!", message: "Username and password are required")
        } else {
            
            if signUpState == true {
                let user = PFUser()
                user.username = username.text
                user.password = password.text
                
                user["isDriver"] = `switch`.on
                
                user.signUpInBackgroundWithBlock({ (succeded, error) in
                    if let error = error {
                        if let errorString = error.userInfo["error"] as? String {
                            self.displayAlert("Sign Up Failed", message: errorString)
                        }
                    } else {
                        
                        if user["isDriver"]! as? Bool == true {
                            
                            self.performSegueWithIdentifier("loginDriver", sender: self)
                            
                        } else {
                        
                            self.performSegueWithIdentifier("loginRider", sender: self)
                        }
                        
                    }
                })
            } else {
                PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) in
                    if let user = user {
                        if user["isDriver"]! as? Bool == true {
                            
                            self.performSegueWithIdentifier("loginDriver", sender: self)
                            
                        } else {
                            
                            self.performSegueWithIdentifier("loginRider", sender: self)
                        }
                    } else {
                        if let errorString = error!.userInfo["error"] as? String {
                            self.displayAlert("LogIn Failed", message: errorString)
                        }
                    }
                })
            }
        }
    }
    
    @IBOutlet var signUpButton: UIButton!
    @IBAction func toggleSignup(sender: AnyObject) {
        
        if signUpState == true {
            signUpButton.setTitle("Log In", forState: UIControlState.Normal)
            toggleSignupButton.setTitle("Switch to Sign Up", forState: UIControlState.Normal)
            
            signUpState = false
            
            riderLabel.alpha = 0
            driverlabel.alpha = 0
            `switch`.alpha = 0
        } else {
            signUpButton.setTitle("Sign Up", forState: UIControlState.Normal)
            toggleSignupButton.setTitle("Switch to Login", forState: UIControlState.Normal)
            
            signUpState = true
            
            riderLabel.alpha = 1
            driverlabel.alpha = 1
            `switch`.alpha = 1

        }
        
    }
    
    
    @IBOutlet var toggleSignupButton: UIButton!
    override func viewDidLoad(){
        super.viewDidLoad()
    
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        self.username.delegate = self;
        self.password.delegate = self;
 
    }

    func DismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if PFUser.currentUser()?.username != nil {
            if PFUser.currentUser()?["isDriver"]! as? Bool == true {
                
                self.performSegueWithIdentifier("loginDriver", sender: self)
                
            } else {
                
                self.performSegueWithIdentifier("loginRider", sender: self)
            }
        }
        
    }
}
