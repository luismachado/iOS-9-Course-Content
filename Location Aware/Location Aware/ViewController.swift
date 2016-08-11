//
//  ViewController.swift
//  Location Aware
//
//  Created by Luís Machado on 07/01/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var nearestAddressLabel: UILabel!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        let userLocation: CLLocation = locations[0]
        latitudeLabel.text = "Latitude: \(userLocation.coordinate.latitude)"
        longitudeLabel.text = "Longitude: \(userLocation.coordinate.longitude)"
        courseLabel.text = "Course: \(userLocation.course)"
        speedLabel.text = "Speed: \(userLocation.speed)"
        altitudeLabel.text = "Altitude: \(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                print(error)
                return
            } else {
                if let p = placemarks?[0] {
                    var subThoroughfare:String = ""
                    
                    if(p.subThoroughfare != nil) {
                        subThoroughfare = p.subThoroughfare!
                    }
                    
                    self.nearestAddressLabel.text = "Address: \(subThoroughfare) \(p.thoroughfare) \n \(p.subLocality) \(p.subAdministrativeArea) \n \(p.postalCode) \(p.country)"
                }
            }
        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

