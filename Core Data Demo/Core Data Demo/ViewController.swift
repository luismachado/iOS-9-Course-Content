//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Luís Machado on 22/06/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        /*var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
        
        newUser.setValue("Tommy", forKey: "username")
        newUser.setValue("ppass123", forKey: "password")
        
        do {
            try context.save()
        } catch {
            print("There was a problem!")
        }*/
        
        let request = NSFetchRequest(entityName: "Users")
        
        //request.predicate = NSPredicate(format: "username = %@", "Ralphie") // Refine search
        
        request.returnsObjectsAsFaults = false //To actually return the data
        
        do {
            let results = try context.executeFetchRequest(request)
            //print(results)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    //print(result.valueForKey("username")!)
                    //print(result.valueForKey("password")!)
                    
                    
                    //UPDATE//
                    /*result.setValue("Ralphie", forKey: "username")
                    
                    do {
                        try context.save()
                    } catch {
                        print("There was a problem!")
                    }*/
                    //UPDATE//
                    
                    //DELETE
                    /*context.deleteObject(result)
                    
                    do {
                        try context.save()
                    } catch {
                        print("There was a problem!")
                    }*/
                    //DELETE
 
                    if let username = result.valueForKey("username") as? String { // Cast object to correct type
                        print (username)
                    }
                    
                }
            }
            
        } catch {
            print("Fetch failed")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

