//
//  ViewController.swift
//  Map Demo
//
//  Created by Luís Machado on 17/12/15.
//  Copyright © 2015 LuisMachado. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        let latitude:CLLocationDegrees = 38.698143
        let longitude:CLLocationDegrees = -9.346283
        let latDelta:CLLocationDegrees = 0.001
        let lonDelta:CLLocationDegrees = 0.001
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        // Annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Niagra Falls"
        annotation.subtitle = "One day I'll go here..."
        
        map.addAnnotation(annotation)
        
        // Long press to add annotation
        let uilpgr = UILongPressGestureRecognizer(target: self, action: "action:") //: means that it will add the gestureRecognizer
        uilpgr.minimumPressDuration = 2
        
        map.addGestureRecognizer(uilpgr)
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        let userLocations: CLLocation = locations[0]
        let latitude = userLocations.coordinate.latitude
        let longitude = userLocations.coordinate.longitude
        
        let latDelta:CLLocationDegrees = 0.005
        let lonDelta:CLLocationDegrees = 0.005
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.map.setRegion(region, animated: true)
    }
    
    func action(gestureRecognizer:UIGestureRecognizer) {
        //print("Gesture Recognized")
        
        let touchPoint = gestureRecognizer.locationInView(self.map)
        let newCoordinate:CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        
        // Annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinate
        annotation.title = "New place"
        annotation.subtitle = "One day I'll go here..."
        map.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

