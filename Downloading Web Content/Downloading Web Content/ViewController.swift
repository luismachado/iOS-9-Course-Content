//
//  ViewController.swift
//  Downloading Web Content
//
//  Created by Luís Machado on 29/11/15.
//  Copyright © 2015 LuisMachado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string:"http://www.stackoverflow.com")!
        
        webView.loadRequest(NSURLRequest(URL: url))
        /*
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in

            // Will happen when task completes
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //print(webContent)
                    self.webView.loadHTMLString(String(webContent!), baseURL: nil)
                    self.webView.
                })
                
                
                
            } else {
                
                // Show error message
                
            }
            
        }
        
        task.resume()*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

