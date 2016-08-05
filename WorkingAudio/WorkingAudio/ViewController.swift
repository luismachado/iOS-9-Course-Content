//
//  ViewController.swift
//  WorkingAudio
//
//  Created by Luís Machado on 21/06/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player:AVAudioPlayer = AVAudioPlayer()

    @IBOutlet var volumeValue: UISlider!
    
    @IBAction func playButton(sender: AnyObject) {
        player.play()
    }
    
    @IBAction func pauseButton(sender: AnyObject) {
        player.pause()
    }
    
    @IBAction func changeVolume(sender: AnyObject) {
        player.volume = volumeValue.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let audioPath = NSBundle.mainBundle().pathForResource("bach", ofType: "mp3")!
        
        do {
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
        } catch {
            
        }

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

