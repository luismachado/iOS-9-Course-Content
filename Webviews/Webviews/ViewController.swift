//
//  ViewController.swift
//  Webviews
//
//  Created by Luís Machado on 24/06/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let url = NSURL(string: "https://www.google.com")
        
        let request = NSURLRequest(URL: url!)
        
        webview.loadRequest(request)*/
        
        
        let html = "<html><body><h1>My Page</he><p>This is my web page.</p></body></html>"
        
        webview.loadHTMLString(html, baseURL: nil)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

