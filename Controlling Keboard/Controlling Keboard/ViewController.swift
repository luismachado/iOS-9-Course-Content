//
//  ViewController.swift
//  Controlling Keboard
//
//  Created by Luís Machado on 26/11/15.
//  Copyright © 2015 LuisMachado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var box: UITextField!
    @IBOutlet var textfinal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.box.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func pressed(sender: AnyObject) {
        
        textfinal.text = box.text
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

