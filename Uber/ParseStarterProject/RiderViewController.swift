//
//  RiderViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Luís Machado on 02/08/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import MapKit

class RiderViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var callUberButton: UIButton!
    var locationManager:CLLocationManager = CLLocationManager()
    var latitude: CLLocationDegrees = 0
    var longitude: CLLocationDegrees = 0
    var riderRequestActive = false //maybe not? has to check if request already made!
    var driverOnTheWay = false
    
    @IBOutlet var map: MKMapView!
    @IBAction func callUber(sender: AnyObject) {
        
        if riderRequestActive == false {
            let riderRequest = PFObject(className: "riderRequest")
            riderRequest["username"] = PFUser.currentUser()?.username
            riderRequest["location"] = PFGeoPoint(latitude: latitude, longitude: longitude)
            
            riderRequest.saveInBackgroundWithBlock { (success, error) in
                if success {
                    self.callUberButton.setTitle("Cancel Uber", forState: UIControlState.Normal)
                } else {
                    let alert = UIAlertController(title: "Could not call uber", message: "Please try again later", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
            }
            riderRequestActive = true
        } else {
            self.callUberButton.setTitle("Cancel Uber", forState: UIControlState.Normal)
            riderRequestActive = false
            
            let query = PFQuery(className: "riderRequest")
            query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
            query.findObjectsInBackgroundWithBlock({ (objects, error) in
                
                if error == nil {
                    print("Successfuly retrieved \(objects!.count) scores.")
                    
                    if let objects = objects {
                        for object in objects {
                            object.deleteInBackground()
                        }
                    }
                } else {
                    print(error)
                }
            })
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location:CLLocationCoordinate2D = manager.location!.coordinate
        //print("locations = \(location.latitude) \(location.longitude)")
        latitude = location.latitude
        longitude = location.longitude
        
        let query = PFQuery(className: "riderRequest")
        query.whereKey("username", equalTo: PFUser.currentUser()!.username!)
        query.findObjectsInBackgroundWithBlock({ (objects, error) in
            
            if error == nil {
                //print("Successfuly retrieved \(objects!.count) scores.")
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        if let driverUsername = object["driverResponded"] {
                        
                            //self.callUberButton.setTitle("Driver is on the way!", forState: UIControlState.Normal)
                            
                            let query = PFQuery(className: "driverLocation")
                            query.whereKey("username", equalTo: driverUsername)
                            query.findObjectsInBackgroundWithBlock({ (objects, error) in
                                
                                if error == nil {
                                    //print("Successfuly retrieved \(objects!.count) scores.")
                                    
                                    if let objects = objects {
                                        
                                        for object in objects {
                                            
                                            if let driverLocation = object["driverLocation"] as? PFGeoPoint {
                                                
                                                let driverCLLocation = CLLocation(latitude: driverLocation.latitude, longitude: driverLocation.longitude)
                                                let distanceKM = (manager.location?.distanceFromLocation(driverCLLocation))! / 1000
                                                let roundedTwoDigitDistance = Double(round(distanceKM * 10) / 10)
                                                
                                                self.callUberButton.setTitle("Driver is \(roundedTwoDigitDistance)km away!", forState: UIControlState.Normal)
                                                
                                                self.driverOnTheWay = true
                                                
                                                let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                                                
                                                let latDelta = abs(driverLocation.latitude - location.latitude) * 2 + 0.02
                                                let longDelta = abs(driverLocation.longitude - location.longitude) * 2 + 0.02
                                                
                                                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta))
                                                
                                                self.map.setRegion(region, animated: true)
                                                
                                                self.map.removeAnnotations(self.map.annotations)
                                                
                                                var pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.latitude, location.longitude)
                                                var objectAnnotation = MKPointAnnotation()
                                                objectAnnotation.coordinate = pinLocation
                                                objectAnnotation.title = "Your Location"
                                                self.map.addAnnotation(objectAnnotation)
                                                
                                                pinLocation = CLLocationCoordinate2DMake(driverLocation.latitude, driverLocation.longitude)
                                                objectAnnotation = MKPointAnnotation()
                                                objectAnnotation.coordinate = pinLocation
                                                objectAnnotation.title = "Driver Location"
                                                self.map.addAnnotation(objectAnnotation)
                                            }
                                            
                                        }
                                    }
                                }
                            })
                            
                        }
                        
                    }
                }
            }
        })
        
        if !driverOnTheWay {
            let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.map.setRegion(region, animated: true)
            
            self.map.removeAnnotations(map.annotations)
            
            let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.latitude, location.longitude)
            let objectAnnotation = MKPointAnnotation()
            objectAnnotation.coordinate = pinLocation
            objectAnnotation.title = "Your Location"
            self.map.addAnnotation(objectAnnotation)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "logoutRider" {
            PFUser.logOut()
        }
        
    }

}
