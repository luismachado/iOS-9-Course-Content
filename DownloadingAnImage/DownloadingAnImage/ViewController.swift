//
//  ViewController.swift
//  DownloadingAnImage
//
//  Created by Luís Machado on 23/06/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/6/6a/Johann_Sebastian_Bach.jpg")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            
            if error != nil {
                print(error)
            } else {
                
                var documentsDirectory:String?
                
                var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                
                
                if paths.count > 0 {
                    documentsDirectory = paths[0] as? String
                    
                    let savePath = documentsDirectory! + "/bach.jpg"
                    
                    NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
                    
                    dispatch_async(dispatch_get_main_queue(), { //avoid update from background thread
                        self.image.image = UIImage(named: savePath)
                    })
                    
                }
                
                
                
                //dispatch_async(dispatch_get_main_queue(), { //avoid update from background thread
                //    if let bach = UIImage(data: data!) {
                //        self.image.image = bach
                //    }
                //})
            }
            
        }
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

