//
//  ViewController.swift
//  Weather Forecast
//
//  Created by Luís Machado on 01/12/15.
//  Copyright © 2015 LuisMachado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityToSearch: UITextField!
    @IBOutlet var weather: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func searchWeather(sender: AnyObject) {
        
        var wasSuccessful = false
        
        if let cityName = cityToSearch.text {
            
            let attempedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityName.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
            
            if let url = attempedUrl {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
           
                if let urlContent = data {
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                    
                    if websiteArray.count > 1 {
                        let weatherArray = websiteArray[1].componentsSeparatedByString("</span>")
                        
                        if websiteArray.count > 1 {
                            
                            wasSuccessful = true
                            
                            let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.weather.text = weatherSummary
                            })
                            

                        }
                    }
                }
                
                if wasSuccessful == false {
                    print("not")
                    self.weather.text = "Error."
                }
                
            }
                task.resume()
            }
            else {
                print("url")
                self.weather.text = "error with url."
            }
        } else {
            print("name")
            weather.text = "Please insert a city name!"
        }
        
    }
}

