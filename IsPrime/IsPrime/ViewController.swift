//
//  ViewController.swift
//  IsPrime
//
//  Created by Luís Machado on 21/11/15.
//  Copyright © 2015 LuisMachado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var number: UITextField!
    @IBOutlet var outputMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isPrime(number:Double)->Bool {
        print(number)
        if number == 2.0 || number == 3.0 {
            print("2 ou 3")
            return true
        }
        if number % 2.0 == 0 || number % 3.0 == 0 {
            print("%2 ou %3")
            return false
        }
        
        var i = 5.0
        var w = 3.0
        
        while i * i <= number {
            if number % i == 0 {
                print("loop")
                return false
            }
            i += w
            w = 6 - w
        }
        print("fim")
        return true
    }

    @IBAction func checkButtonPressed(sender: AnyObject) {
        outputMessage.text = "Checking..."
        
        if let myNumber = Double(number.text!) {
            if isPrime(myNumber) {
                outputMessage.text = "The number you select is a prime!"
            } else {
                outputMessage.text = "The number you select isn't a prime!"
            }
        } else {
            outputMessage.text = "Please insert a number!"
        }
        
        /*if number.text! != ""  {
            if isPrime(Double(number.text!)!) {
                outputMessage.text = "The number you select is a prime!"
            } else {
                outputMessage.text = "The number you select isn't a prime!"
            }
        }*/
    }

}

