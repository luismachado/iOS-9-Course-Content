//
//  ViewController.swift
//  Animations
//
//  Created by Luís Machado on 03/12/15.
//  Copyright © 2015 LuisMachado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var frameArray:[UIImage] = []
    var currentFrame = 0
    var timer = NSTimer()
    
    @IBOutlet var alienImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for var i = 1; i < 6; i++ {
            frameArray.append(UIImage(named: "frame\(i).jpg")!)
        }
        for var i = 4; i > 1; i-- {
            frameArray.append(UIImage(named: "frame\(i).jpg")!)
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("doAnimation"), userInfo: nil, repeats: true)
        
    }
    
    func doAnimation() {
        
        currentFrame++
        if currentFrame >= frameArray.count {
            currentFrame = 0
        }
        
        alienImage.image = frameArray[currentFrame]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func updateImage(sender: AnyObject) {
        
        //doAnimation()
        
        if timer.valid {
            timer.invalidate()
        } else {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("doAnimation"), userInfo: nil, repeats: true)
        }
    }
    
    
    
    
    
    
    
    /*override func viewDidLayoutSubviews() {
        //alienImage.center = CGPointMake(alienImage.center.x - 400, alienImage.center.y)
        //alienImage.alpha = 0;
        alienImage.frame = CGRectMake(100, 20, 0, 0)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1) { () -> Void in
            
            //self.alienImage.center = CGPointMake(self.alienImage.center.x + 400, self.alienImage.center.y)
            //self.alienImage.alpha = 1
            self.alienImage.frame = CGRectMake(100, 20, 100, 200)
        }
    }*/

}

