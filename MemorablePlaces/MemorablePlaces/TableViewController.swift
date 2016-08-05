//
//  TableViewController.swift
//  MemorablePlaces
//
//  Created by Luís Machado on 17/06/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit

struct Location {
    let name: String
    let latitude: Double
    let longitude: Double
}

var locationList:[Dictionary<String,String>] = [Dictionary<String,String>]()

var activePlace = -1

class TableViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NSUserDefaults.standardUserDefaults().objectForKey("locationList") != nil {
            locationList = NSUserDefaults.standardUserDefaults().objectForKey("locationList")! as! [Dictionary<String,String>]
        }
        
        if locationList.count == 0 {
            locationList.append(["name": "Taj Mahal", "latitude": "27.175277", "longitude": "78.0421"])
        }
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return locationList.count
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = locationList[indexPath.row]["name"]
        return cell
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        
        activePlace = indexPath.row
        
        performSegueWithIdentifier("locationSegue", sender: indexPath.row)
        return indexPath
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            locationList.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(locationList, forKey: "locationList")
            self.tableView.reloadData()
            
        }
    }
     


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addSegue" {
            activePlace = -1
        }
    }
    

}
