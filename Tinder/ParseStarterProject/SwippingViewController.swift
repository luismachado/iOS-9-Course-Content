//
//  SwippingViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Luís Machado on 26/07/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class SwippingViewController: UIViewController {

    @IBOutlet var userImage: UIImageView!
    @IBOutlet var infoLabel: UILabel!
    
    var displayedUserId = ""
    
    func updateImage() {
        let query = PFUser.query()!
        // Filter by geolocation
        
        if let latitude = PFUser.currentUser()?["location"]?.latitude {
            if let longitude = PFUser.currentUser()?["location"]?.longitude {
                query.whereKey("location",
                               withinGeoBoxFromSouthwest: PFGeoPoint(latitude: latitude - 10, longitude: longitude - 10),
                               toNortheast: PFGeoPoint(latitude: latitude + 10, longitude: longitude + 10))
            }
        }
        
        
        
        var interestedIn = "male"
        if  (PFUser.currentUser()?["interestedInWomen"])! as! Bool == true {
            interestedIn = "female"
        }
        
        var isFemale = true
        
        if (PFUser.currentUser()?["gender"])! as! String == "male" {
            isFemale = false
        }
        
        query.whereKey("gender", equalTo: interestedIn)
        query.whereKey("interestedInWomen", equalTo: isFemale)
        
        var ignoredUsers = [""]
        
        if let acceptedUsers = PFUser.currentUser()?["accepted"]  {
            ignoredUsers += acceptedUsers as! Array
        }
        
        if let rejectedUsers = PFUser.currentUser()?["rejected"]{
            ignoredUsers += rejectedUsers as! Array
        }
        
        query.whereKey("objectId", notContainedIn: ignoredUsers)
        
        query.limit = 1
        
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            
            if error != nil {
                print(error)
            } else if let objects = objects {
                for object in objects {
                    
                    //print(object)
                    self.displayedUserId = object.objectId!
                    
                    let imageFile = object["image"] as! PFFile
                    imageFile.getDataInBackgroundWithBlock({ (imageData, error) in
                        
                        if error != nil {
                            print (error)
                        } else {
                            if let data = imageData {
                                self.userImage.image = UIImage(data: data)
                            }
                        }
                        
                    })
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gesture creation
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(SwippingViewController.wasDragged(_:)))
        userImage.addGestureRecognizer(gesture)
        userImage.userInteractionEnabled = true
        
        //geolocalization
        PFGeoPoint.geoPointForCurrentLocationInBackground { (geoPoint, error) in
            
            if let geoPoint = geoPoint {
                PFUser.currentUser()?["location"] = geoPoint
                do {
                    try PFUser.currentUser()?.save()
                } catch {
                    print("There was a problem!")
                }
            }
        }
        
        updateImage()
    }
    
    func wasDragged(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translationInView(self.view)
        let label = gesture.view!
        
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        //Transformations
        let xFromCenter = label.center.x - self.view.bounds.width / 2
        
        let scale = min(100 / abs(xFromCenter), 1)
        
        var rotation = CGAffineTransformMakeRotation(xFromCenter / 200)
        var strech = CGAffineTransformScale(rotation, scale, scale)
        
        label.transform = strech
        
        // Center back and decide
        if gesture.state == UIGestureRecognizerState.Ended {
            
            var acceptedOrRejected = ""
            
            if label.center.x < 100 {
                print("Not chosen")
                acceptedOrRejected = "rejected"
            } else if label.center.x > self.view.bounds.width - 100 {
                print("Chosen")
                acceptedOrRejected = "accepted"
            }
            
            if acceptedOrRejected != "" {
                PFUser.currentUser()?.addUniqueObjectsFromArray([displayedUserId], forKey: acceptedOrRejected)
                
                do {
                    try PFUser.currentUser()?.save()
                } catch {
                    print("There was a problem!")
                }
                
            }
            
            rotation = CGAffineTransformMakeRotation(0)
            strech = CGAffineTransformScale(rotation, 1, 1)
            label.transform = strech
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
            
            updateImage()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "logOut" {
            PFUser.logOut()
        }
        
    }

}
