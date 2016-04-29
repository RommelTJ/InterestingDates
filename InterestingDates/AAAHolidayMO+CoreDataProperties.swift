//
//  AAAHolidayMO+CoreDataProperties.swift
//  InterestingDates
//
//  Created by Rommel Rico on 4/29/16.
//  Copyright © 2016 Rommel Rico. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension AAAHolidayMO {

    @NSManaged var createdAt: NSDate?
    @NSManaged var date: NSDate?
    @NSManaged var details: String?
    @NSManaged var image: NSData?
    @NSManaged var name: String?
    @NSManaged var objectId: String?
    @NSManaged var observedBy: NSObject?
    @NSManaged var syncStatus: NSNumber?
    @NSManaged var updatedAt: NSDate?
    @NSManaged var wikipediaLink: String?

}
