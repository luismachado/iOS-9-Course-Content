//
//  ViewController.swift
//  TicTacToe
//
//  Created by Luís Machado on 10/12/15.
//  Copyright © 2015 LuisMachado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var buttonsPressed = [0,0,0,0,0,0,0,0,0]
    var gameState = [0,0,0,0,0,0,0,0,0]
    var iconsArray = [UIImage(named: "circle.png"),UIImage(named: "cross.png")]
    var currentPlayer = 1 // 1 or 2
    var numberOfPlays = 0

    @IBOutlet var playAgainButton: UIButton!
    @IBOutlet var currentPlayerPlaying: UILabel!
    @IBOutlet var grid: UIImageView!
    @IBOutlet var endGameMessage: UILabel!
    @IBOutlet var button: UIButton!
    @IBOutlet var fillingLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepNewGame()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        
        if validPress(sender.tag!) {
            endGameMessage.text = ""
            numberOfPlays++
            gameState[sender.tag] = currentPlayer
            sender.setImage(iconsArray[currentPlayer-1], forState: .Normal)
            
            if victoryAchieved(sender.tag, playerNum: currentPlayer) {
                prepEndGame("Player \(currentPlayer) won!!")
            } else if numberOfPlays == 9 {
                prepEndGame("It's a draw!")
            } else {
                if currentPlayer == 1 {
                    currentPlayer = 2
                } else {
                    currentPlayer = 1
                }
                currentPlayerPlaying.text = "Player \(currentPlayer)"
            }
        } else {
            endGameMessage.text = "Already pressed!"
        }
    }
    
    @IBAction func playAgainPressed(sender: AnyObject) {
        prepNewGame()
    }
    
    func prepNewGame() {
        fillingLabel.hidden = true
        fillingLabel.center = CGPointMake(fillingLabel.center.x - 500, fillingLabel.center.y)
        playAgainButton.hidden = true
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 500, playAgainButton.center.y)
        
        buttonsPressed = [0,0,0,0,0,0,0,0,0]
        gameState = [0,0,0,0,0,0,0,0,0]
        currentPlayer = 1
        currentPlayerPlaying.text = "Player \(currentPlayer)"
        numberOfPlays = 0
        
        endGameMessage.text = ""
        
        var buttonToClear : UIButton
        for var i = 0; i < 9; i++ {
            buttonToClear = view.viewWithTag(i) as! UIButton
            buttonToClear.setImage(nil, forState: .Normal)
            buttonToClear.enabled = true
        }
        
    }
    
    func prepEndGame(message : String) {
        endGameMessage.text = message
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.fillingLabel.hidden = false
            self.fillingLabel.center = CGPointMake(self.fillingLabel.center.x + 500, self.fillingLabel.center.y)
            self.playAgainButton.hidden = false
            self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x + 500, self.playAgainButton.center.y)
        }
        
        
        
        var buttonToClear : UIButton
        for var i = 0; i < 9; i++ {
            buttonToClear = view.viewWithTag(i) as! UIButton
            buttonToClear.enabled = false
        }
        
    }
    
    func validPress(buttonPressNumber : Int) -> Bool {
        if buttonsPressed[buttonPressNumber] == 0 {
            buttonsPressed[buttonPressNumber] = 1
            return true
        }
        return false
    }
    
    func victoryAchieved(buttonPressedNumber: Int, playerNum : Int) -> Bool {
        if numberOfPlays < 5 {
            return false
        } else {
            print("Checking: buttonPressed[\(buttonPressedNumber)] - player[\(playerNum)]")
            let x = buttonPressedNumber % 3
            let y = buttonPressedNumber / 3
            
            print(gameState)
            
            // Horizontal Check
            for var i = 0; i < 3; i++ {
                print("Checking horizontal \((x*3)+i)")
                if gameState[(y*3)+i] == playerNum {
                    if i == 2 {
                        return true
                    }
                } else {
                    break
                }
                
            }
            // Vertical Check
            for var i = 0; i < 3; i++ {
                print("Checking vertical \(y+(i*3))")
                if gameState[x+(i*3)] == playerNum {
                    if i == 2 {
                        return true
                    }
                } else {
                    break
                }
            }
            
            // Diagonal
            if buttonPressedNumber == 0 || buttonPressedNumber == 2 || buttonPressedNumber == 4 || buttonPressedNumber == 6 || buttonPressedNumber == 8 {
                print("Checking diag")
                // Up left to down right
                for var i = 0; i < 3; i++ {
                    if gameState[i+(i*3)] == playerNum {
                        if i == 2 {
                            return true
                        }
                    } else {
                        break
                    }
                }
                // Down left to up right
                for var i = 0; i < 3; i++ {
                    if gameState[(i+1)*2] == playerNum {
                        if i == 2 {
                            return true
                        }
                    } else {
                        break
                    }
                }
            }
        }
        return false
    }

}