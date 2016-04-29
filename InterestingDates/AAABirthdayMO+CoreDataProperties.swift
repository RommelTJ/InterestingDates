//
//  AAABirthdayMO+CoreDataProperties.swift
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

extension AAABirthdayMO {

    @NSManaged var createdAt: NSDate?
    @NSManaged var date: NSDate?
    @NSManaged var facebook: String?
    @NSManaged var giftIdeas: String?
    @NSManaged var image: NSData?
    @NSManaged var name: String?
    @NSManaged var objectId: String?
    @NSManaged var syncStatus: NSNumber?
    @NSManaged var updatedAt: NSDate?

}
