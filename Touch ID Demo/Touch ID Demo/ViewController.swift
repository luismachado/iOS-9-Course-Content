//
//  ViewController.swift
//  Touch ID Demo
//
//  Created by Luís Machado on 09/08/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authenticationContext = LAContext()
        var error: NSError?
        
        
        if authenticationContext.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            authenticationContext.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "We need to know who you are...") { (success, error) in
                
                if success {
                    // user authenticated
                    print("authenticated!")
                } else {
                    if let error = error {
                        print(error)
                    } else {
                        print("falhou")
                        // user did not authenticate
                    }
                }
                
            }
        } else {
            // no touch id available
        }
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

