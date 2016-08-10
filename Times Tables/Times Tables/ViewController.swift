//
//  ViewController.swift
//  Times Tables
//
//  Created by Luís Machado on 23/11/15.
//  Copyright © 2015 LuisMachado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var timerPosition: UISlider!
    var currentPosition = 0
    
    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return array[currentPosition].count
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        let timesTable = Int(timerPosition.value * 20)
       
        cell.textLabel?.text = String(timesTable * (indexPath.row + 1))
    
        return cell
        
    }
    @IBAction func refreshPosition(sender: AnyObject) {
        //currentPosition = Int(timerPosition.value)
        //print(timerPosition)
        table.reloadData()
    }

}

