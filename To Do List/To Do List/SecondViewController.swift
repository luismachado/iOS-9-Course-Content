//
//  SecondViewController.swift
//  To Do List
//
//  Created by Luís Machado on 26/11/15.
//  Copyright © 2015 LuisMachado. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var newItemText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newItemText.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func addItem(sender: AnyObject) {
        
            todoList.append(newItemText.text!)
            newItemText.text = ""
            NSUserDefaults.standardUserDefaults().setObject(todoList, forKey: "todoList")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

