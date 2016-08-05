//
//  ViewController.swift
//  Back2Bach
//
//  Created by Luís Machado on 21/06/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player:AVAudioPlayer = AVAudioPlayer()
    var timer = NSTimer()
    
    @IBOutlet var volumeValue: UISlider!
    @IBOutlet var skipValue: UISlider!
    @IBOutlet var currentTime: UILabel!
    
    @IBAction func playButton(sender: AnyObject) {
        player.play()
    }
    
    @IBAction func pauseButton(sender: AnyObject) {
        player.pause()
    }
    
    @IBAction func stopButton(sender: AnyObject) {
        player.stop()
        player.currentTime = 0
    }
    
    @IBAction func changeVolume(sender: AnyObject) {
        player.volume = volumeValue.value
    }
    
    @IBAction func skipMusic(sender: AnyObject) {
        player.currentTime = Double(skipValue.value * Float(player.duration))
        
    }
    
    func updateTime() {
        
        let minutes:Int = Int(player.currentTime / 60)
        let seconds:Int = Int(player.currentTime % 60)
        
        var stringMinutes = "\(minutes)"
        if minutes < 10 {
            stringMinutes = "0\(minutes)"
        }
        
        var stringSeconds = "\(seconds)"
        if seconds < 10 {
            stringSeconds = "0\(seconds)"
        }

        let stringTime = "\(stringMinutes):\(stringSeconds)"
        
        currentTime.text = stringTime
        
        skipValue.value = Float(player.currentTime / player.duration)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skipValue.value = 0
        
        let audioPath = NSBundle.mainBundle().pathForResource("Joey", ofType: "mp3")!
        currentTime.text = "00:00"
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.updateTime), userInfo: nil, repeats: true)
        
        
        do {
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
            
        } catch {
            
        }
        
        player.volume = volumeValue.value
        print(player.duration)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

