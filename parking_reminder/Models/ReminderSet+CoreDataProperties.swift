//
//  ReminderSet+CoreDataProperties.swift
//  parking_reminder
//
//  Created by Vincent Lee on 4/11/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//
//

import Foundation
import CoreData


extension ReminderSet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReminderSet> {
        return NSFetchRequest<ReminderSet>(entityName: "ReminderSet")
    }

    @NSManaged public var day: Int16
    @NSManaged public var hour: Int16
    @NSManaged public var minute: Int16
    @NSManaged public var reminders: NSSet
    @NSManaged public var type: String

}

// MARK: Generated accessors for reminders
extension ReminderSet {

    @objc(addRemindersObject:)
    @NSManaged public func addToReminders(_ value: Reminder)

    @objc(removeRemindersObject:)
    @NSManaged public func removeFromReminders(_ value: Reminder)

    @objc(addReminders:)
    @NSManaged public func addToReminders(_ values: NSSet)

    @objc(removeReminders:)
    @NSManaged public func removeFromReminders(_ values: NSSet)

}
