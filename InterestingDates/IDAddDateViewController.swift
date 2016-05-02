//
//  IDAddDateViewController.swift
//  InterestingDates
//
//  Created by Rommel Rico on 4/29/16.
//  Copyright © 2016 Rommel Rico. All rights reserved.
//

import UIKit
import CoreData

class IDAddDateViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var option1TextField: UITextField!
    @IBOutlet weak var option2TextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    let AddDateCompletionBlock: (String) -> Void = { (response) in }
    //typealias AddDateCompletionBlock = (result: String) -> ()
    var entityName: String!
    var managedObjectContext: NSManagedObjectContext!
    var date: NSManagedObject!
    var originalCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedObjectContext = appDelegate.newManagedObjectContext
        self.date = NSEntityDescription.insertNewObjectForEntityForName(self.entityName, inManagedObjectContext: self.managedObjectContext)
        self.datePicker.date = NSDate()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.originalCenter = self.view.center
    }
    
    @IBAction func setADate(sender: AnyObject) {
        self.nameTextField.resignFirstResponder()
        self.option1TextField.resignFirstResponder()
        self.option2TextField.resignFirstResponder()
        
        if self.datePicker.hidden {
            self.datePicker.hidden = false
            UIView.animateWithDuration(0.3, animations: { 
                self.view.center = CGPoint(x: self.originalCenter.x, y: self.originalCenter.y-30)
            })
        } else {
            UIView.animateWithDuration(0.3, animations: { 
                self.view.center = self.originalCenter
                }, completion: { (success) in
                    self.datePicker.hidden = true
            })
        }
    }
    
    @IBAction func cancelAddDate(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveDate(sender: AnyObject) {
        
        if self.nameTextField.text != "" {
            
            self.date.setValue(self.nameTextField.text, forKey: "name")
            self.date.setValue(dateSetToMidnightUsingDate(self.datePicker.date), forKey: "date")
            
            if self.entityName == "Holiday" {
                self.date.setValue(self.option1TextField.text, forKey: "details")
                self.date.setValue(self.option2TextField.text, forKey: "wikipediaLink")
            } else if self.entityName == "Birthday" {
                self.date.setValue(self.option1TextField.text, forKey: "giftIdeas")
                self.date.setValue(self.option2TextField.text, forKey: "facebook")
            }
            
            self.managedObjectContext.performBlockAndWait({ 
                do {
                    try self.managedObjectContext.save()
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.saveMasterContext()
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
            })
            
            self.navigationController?.popViewControllerAnimated(true)
            AddDateCompletionBlock("Done!")            
        }
    }
    
    private func dateSetToMidnightUsingDate(aDate: NSDate) -> NSDate {
        let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = gregorian?.components([.Hour, .Minute, .Second], fromDate: aDate)
        components?.hour = 0
        components?.minute = 0
        components?.second = 0
        return (gregorian?.dateFromComponents(components!))!
    }

}
