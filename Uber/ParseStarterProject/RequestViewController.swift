//
//  RequestViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Luís Machado on 03/08/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import MapKit
import Parse

class RequestViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var map: MKMapView!
    var requestLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var requestUsername:String = ""

    @IBAction func pickUpRider(sender: AnyObject) {
        let query = PFQuery(className: "riderRequest")
        query.whereKey("username", equalTo: requestUsername)
        query.findObjectsInBackgroundWithBlock({ (objects, error) in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        let query = PFQuery(className: "riderRequest")
                        query.getObjectInBackgroundWithId(object.objectId!, block: { (object_returned, error) in
                            if error != nil {
                                print(error)
                            } else if let object_returned = object_returned {
                                object_returned["driverResponded"] = PFUser.currentUser()!.username!
                                object_returned.saveInBackground()
                                
                                let requestCLLocation = CLLocation(latitude: self.requestLocation.latitude, longitude: self.requestLocation.longitude)
                                
                                CLGeocoder().reverseGeocodeLocation(requestCLLocation, completionHandler: { (placemarks, error) in
                                    
                                    if error != nil {
                                        print(error)
                                    } else {
                                        if placemarks?.count > 0 {
                                            let pm = placemarks![0] as CLPlacemark
                                            
                                            let mkPm = MKPlacemark(placemark: pm)
                                            
                                            let mapItem = MKMapItem(placemark: mkPm)
                                            mapItem.name = self.requestUsername
                                            
                                            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                                            mapItem.openInMapsWithLaunchOptions(launchOptions)
                                            
                                        } else {
                                            print("Problem with the data received from the geocoder")
                                        }
                                    }
                                    
                                })
                            }
                        })
                    }
                }
            } else {
                print(error)
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(requestUsername)
        //print(requestLocation)
        
        let region = MKCoordinateRegion(center: requestLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
        
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = requestLocation
        objectAnnotation.title = requestUsername
        self.map.addAnnotation(objectAnnotation)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
