//
//  Reminder+CoreDataProperties.swift
//  parking_reminder
//
//  Created by Vincent Lee on 4/11/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var day: Int16
    @NSManaged public var type: String
    @NSManaged public var identifier: String
    @NSManaged public var hour: Int16
    @NSManaged public var minute: Int16

}
