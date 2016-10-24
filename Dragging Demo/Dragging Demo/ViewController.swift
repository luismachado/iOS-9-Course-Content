//
//  ViewController.swift
//  Dragging Demo
//
//  Created by Luís Machado on 20/07/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //var startingPosition = CGPoint(x: 0, y: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let label = UILabel(frame: CGRectMake(self.view.bounds.width / 2  - 100, self.view.bounds.height / 2  - 50, 200, 100))
        label.text = "Drag me!"
        label.textAlignment = NSTextAlignment.Center
        self.view.addSubview(label)
        
        //Gesture creation
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.wasDragged(_:)))
        label.addGestureRecognizer(gesture)
        label.userInteractionEnabled = true
    }
    
    
    func wasDragged(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translationInView(self.view)
        let label = gesture.view!
        
        
        
        /*if gesture.state == UIGestureRecognizerState.Began {
            startingPosition = label.center
        }
        label.center = CGPoint(x: startingPosition.x + translation.x, y: startingPosition.y + translation.y)*/
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        //Transformations
        let xFromCenter = label.center.x - self.view.bounds.width / 2
        
        let scale = min(100 / abs(xFromCenter), 1)
        
        var rotation = CGAffineTransformMakeRotation(xFromCenter / 200)
        var strech = CGAffineTransformScale(rotation, scale, scale)
        
        label.transform = strech
        
        // Center back and decide
        if gesture.state == UIGestureRecognizerState.Ended {
            
            if label.center.x < 100 {
                print("Not chosen")
            } else if label.center.x > self.view.bounds.width - 100 {
                print("Chosen")
            }
            
            rotation = CGAffineTransformMakeRotation(0)
            strech = CGAffineTransformScale(rotation, 1, 1)
            label.transform = strech
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

