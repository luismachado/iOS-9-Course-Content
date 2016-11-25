//
//  UserTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Luís Machado on 09/08/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse


class UserTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var usernames = [String]()
    var recipientUseranme = ""
    var timer = NSTimer()
    
    func hideMessage() {
        
        for subview in self.view.subviews {
            if subview.tag == 10 {
                subview.removeFromSuperview()
            }
        }
        
    }
    
    func checkForMessage() {
        let query = PFQuery(className: "image")
        query.whereKey("recipientUsername", equalTo: PFUser.currentUser()!.username!)
        
        do {
            let images = try query.findObjects()
            
            if let pfObjects = images as? [PFObject] {
                
                if pfObjects.count > 0 {
                    let imageView: PFImageView = PFImageView()
                    imageView.file = pfObjects[0]["photo"] as! PFFile
                    imageView.loadInBackground({ (photo, error) in
                        if error == nil {
                            
                            var senderUsername = "Unknown User"
                            if let username = pfObjects[0]["senderUsername"] as? String {
                                senderUsername = username
                            }
                            
                            
                            let alert = UIAlertController(title: "You have a message!", message: "Message from \(senderUsername)", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) in
                                
                                let backgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
                                backgroundView.backgroundColor = UIColor.blackColor()
                                backgroundView.alpha = 0.8
                                backgroundView.contentMode = UIViewContentMode.ScaleAspectFit
                                backgroundView.tag = 10
                                self.view.addSubview(backgroundView)
                                
                                let displayedImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
                                displayedImage.image = photo
                                displayedImage.contentMode = UIViewContentMode.ScaleAspectFit
                                displayedImage.tag = 10
                                self.view.addSubview(displayedImage)
                                
                                
                                do {
                                    try pfObjects[0].delete()
                                } catch {}
                                
                                
                                _ = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(UserTableViewController.hideMessage), userInfo: nil, repeats: false)
                            }))
                            self.presentViewController(alert, animated: true, completion: nil)
                        } else {
                            print(error)
                        }
                    })
                }
                
                
                
                
            }
            
        } catch {}
        
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //timer to check for new images recieved
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(UserTableViewController.checkForMessage), userInfo: nil, repeats: true)

        let query = PFUser.query()!
        query.whereKey("username", notEqualTo: (PFUser.currentUser()?.username)!)
        
        do {
            let users = try query.findObjects() as? [PFUser]
            
            for user in users! {
                usernames.append(user.username!)
            }
            
            tableView.reloadData()
        } catch {}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usernames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel?.text = usernames[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        recipientUseranme = usernames[indexPath.row]
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let imageToSend = PFObject(className: "image")
        imageToSend["photo"] = PFFile(name: "photo.jpg", data: UIImageJPEGRepresentation(image, 0.5)!)
        imageToSend["senderUsername"] = PFUser.currentUser()?.username!
        imageToSend["recipientUsername"] = recipientUseranme
        
        let acl = PFACL()
        acl.publicReadAccess = true
        acl.publicWriteAccess = true
        imageToSend.ACL = acl
        
        do {
            try imageToSend.save()
        } catch {}
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Logout" {
            timer.invalidate()
            PFUser.logOut()
        }
        
    }
    

}
