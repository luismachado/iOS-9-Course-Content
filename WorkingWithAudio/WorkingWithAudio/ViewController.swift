//
//  ViewController.swift
//  WorkingWithAudio
//
//  Created by Luís Machado on 21/06/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player:AVAudioPlayer = AVAudioPlayer()

    @IBOutlet var slider: UISlider!
    
    @IBAction func play(sender: AnyObject) {
        let audioPath = NSBundle.mainBundle().pathForResource("bach-bwv924-breemer", ofType: "mp3")!
        
        do {
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
            player.play()
        } catch {
            // Process error here
        }
        
        
    }
    
    @IBAction func pause(sender: AnyObject) {
        player.pause()
        
    }
    
    @IBAction func adjustVolume(sender: AnyObject) {
        player.volume = slider.value
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

