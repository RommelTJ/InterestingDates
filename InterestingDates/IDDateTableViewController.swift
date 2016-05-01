//
//  IDDateTableViewController.swift
//  InterestingDates
//
//  Created by Rommel Rico on 4/29/16.
//  Copyright © 2016 Rommel Rico. All rights reserved.
//

import UIKit
import CoreData

class IDDateTableViewController: UITableViewController {
    // MARK: Properties
    var dates: NSArray!
    var entityName: String!
    var dateFormatter: NSDateFormatter!
    var managedObjectContext: NSManagedObjectContext!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedObjectContext = appDelegate.newManagedObjectContext
        self.dateFormatter = NSDateFormatter()
        self.dateFormatter.timeZone = NSTimeZone(name: "PST")
        self.dateFormatter.dateStyle = .MediumStyle
        
        loadRecordsFromCoreData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    // MARK: Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dates.count
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let date = dates[indexPath.row]
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.newManagedObjectContext
            do {
                managedContext.deleteObject(date as! NSManagedObject)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                try managedContext.save()
                loadRecordsFromCoreData()
                self.tableView.reloadData()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: IDTableViewCell = IDTableViewCell()
        
        if self.entityName == "Holiday" {
            cell = tableView.dequeueReusableCellWithIdentifier("HolidayCell") as! IDTableViewCell
            let holiday = self.dates.objectAtIndex(indexPath.row) as! AAAHolidayMO
            cell.nameLabel.text = holiday.name
            cell.dateLabel.text = self.dateFormatter.stringFromDate(holiday.date!)
            if (holiday.image != nil) {
                let image = UIImage(data: holiday.image!)
                cell.photoView.image = image
            } else {
                cell.photoView.image = nil
            }
        } else { //Birthday
            cell = tableView.dequeueReusableCellWithIdentifier("BirthdayCell") as! IDTableViewCell
            let birthday = self.dates.objectAtIndex(indexPath.row) as! AAABirthdayMO
            cell.nameLabel.text = birthday.name
            cell.dateLabel.text = self.dateFormatter.stringFromDate(birthday.date!)
            if (birthday.image != nil) {
                let image = UIImage(data: birthday.image!)
                cell.photoView.image = image
            } else {
                cell.photoView.image = nil
            }
        }
        
        return cell
    }

    // MARK: Private methods
    
    private func loadRecordsFromCoreData() {
        self.managedObjectContext.performBlockAndWait { 
            self.managedObjectContext.reset()
            let request = NSFetchRequest(entityName: self.entityName)
            let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            do {
                self.dates = try self.managedObjectContext.executeFetchRequest(request)
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        }
    }

}
