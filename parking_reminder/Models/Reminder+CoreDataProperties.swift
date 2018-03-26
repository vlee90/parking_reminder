//
//  Reminder+CoreDataProperties.swift
//  parking_reminder
//
//  Created by Vincent Lee on 3/23/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var date: NSDate
    @NSManaged public var days: [String]
    @NSManaged public var type: String

}

