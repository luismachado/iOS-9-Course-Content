//
//  ViewController.swift
//  JSON Example
//
//  Created by Luís Machado on 23/06/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let url = NSURL(string: "https://freegeoip.net/json/")!
        let url = NSURL(string: "http://lfmachado.com:8083/MySportsSchedule/GetGames")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            
            if let urlContent = data {
                
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    print(jsonResult)
                    
                } catch {
                    print("JSON Serialization Failed")
                }
                
            }
            
        }
        
        task.resume()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

