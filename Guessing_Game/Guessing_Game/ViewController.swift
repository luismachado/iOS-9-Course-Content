//
//  ViewController.swift
//  Guessing_Game
//
//  Created by Luís Machado on 19/11/15.
//  Copyright © 2015 LuisMachado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var randomNumber:Int = 0
    @IBOutlet var guessFingers: UITextField!
    @IBOutlet var resultText: UILabel!
    
    func generateRandomNumber() {
        randomNumber = Int(arc4random_uniform(4))+1
        print(randomNumber)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateRandomNumber()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        
        if guessFingers.text! != ""  {
            print(guessFingers.text)
            let guessFingersNumber = Int(guessFingers.text!)!

            if guessFingersNumber < 1 || guessFingersNumber > 5 {
                    resultText.text = "Please select a number between 1 and 5!"
            } else {
                if guessFingersNumber == randomNumber {
                    resultText.text = "You guessed it! It was \(guessFingersNumber)!. Now try to guess this one!"
                    generateRandomNumber()
                } else {
                    resultText.text = "Nope! It's not \(guessFingersNumber)!. Try again!"
                }
            }
        } else {
            resultText.text = "Please select a number!"
        }
    }

}

