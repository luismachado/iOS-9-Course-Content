//
//  ViewController.swift
//  Git Demo
//
//  Created by Luís Machado on 08/08/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func buttonTapped(sender: AnyObject) {
        
        print("button tapped!")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Hello World!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

