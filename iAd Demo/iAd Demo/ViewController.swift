//
//  ViewController.swift
//  iAd Demo
//
//  Created by Luís Machado on 08/08/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit
import iAd

class ViewController: UIViewController {

    @IBOutlet var adBanner: ADBannerView!
    @IBOutlet var button: UIButton!
    @IBAction func removeAd(sender: AnyObject) {
        
        adBanner.removeFromSuperview()
        button.removeFromSuperview()∑
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.canDisplayBannerAds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

