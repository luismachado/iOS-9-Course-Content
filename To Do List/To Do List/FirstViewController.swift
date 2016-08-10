//
//  FirstViewController.swift
//  To Do List
//
//  Created by Luís Machado on 26/11/15.
//  Copyright © 2015 LuisMachado. All rights reserved.
//

import UIKit

var todoList = [String]()

class FirstViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedList = NSUserDefaults.standardUserDefaults().objectForKey("todoList") {
        
            todoList =  savedList as! [String]
        }
        
        /*if NSUserDefaults.standardUserDefaults().objectForKey("todoList") != nil {
            
            todoList =  NSUserDefaults.standardUserDefaults().objectForKey("todoList") as [String]
        }*/
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = todoList[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            todoList.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(todoList, forKey: "todoList")
            
            table.reloadData()
        }
        
    }
    
    func removeItem(index:Int) {
        todoList.removeAtIndex(index)
    }
    
    override func viewDidAppear(animated: Bool) {
        table.reloadData()
    }
}

