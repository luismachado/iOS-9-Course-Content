//
//  ViewController.swift
//  Hello World
//
//  Created by Luís Machado on 12/11/15.
//  Copyright © 2015 LuisMachado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func submit(sender: AnyObject) {
        
        print("Button tapped")
        label.text = textField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Hello Rob!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

