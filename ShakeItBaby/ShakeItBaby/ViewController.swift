//
//  ViewController.swift
//  ShakeItBaby
//
//  Created by Luís Machado on 22/06/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player:AVAudioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if event?.subtype == UIEventSubtype.MotionShake {
            let randomMusic = String(arc4random_uniform(5)+1)
            print(randomMusic)
            let audioPath = NSBundle.mainBundle().pathForResource("Music (\(randomMusic))", ofType: "mp3")!
            
            do {
                try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
                player.play()
            } catch {
                print("error")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

