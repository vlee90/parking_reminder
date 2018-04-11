//
//  Reminder+CoreDataClass.swift
//  parking_reminder
//
//  Created by Vincent Lee on 3/23/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//
//

import Foundation
import CoreData


public class Reminder: NSManagedObject {
    //  Init
    init(day: Int, hour: Int, minute: Int, type: ReminderType, entity: NSEntityDescription, context: NSManagedObjectContext) {
        super.init(entity: entity, insertInto: context)
        self.day = Int16(day)
        self.hour = Int16(hour)
        self.minute = Int16(minute)
        self.type = type.rawValue
        self.identifier = String.randomNumber()
    }
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
        
    func returnDayOfWeek() -> DaysOfWeek? {
        switch day {
        case 1:
            return DaysOfWeek.Monday
        case 2:
            return DaysOfWeek.Tuesday
        case 3:
            return DaysOfWeek.Wedensday
        case 4:
            return DaysOfWeek.Thursday
        case 5:
            return DaysOfWeek.Friday
        case 6:
            return DaysOfWeek.Saturday
        case 7:
            return DaysOfWeek.Sunday
        default:
            return nil
        }
    }
    
//    func convertToStringDayFrom(enumDays: [DaysOfWeek]) -> [String] {
//        var dayArray = [String]()
//        for day in enumDays {
//            dayArray.append(day.rawValue)
//        }
//        return dayArray
//    }
}

enum DaysOfWeek: String {
    case Monday
    case Tuesday
    case Wedensday
    case Thursday
    case Friday
    case Saturday
    case Sunday
}

enum ReminderType: String {
    case SetLocation
    case FindLocation
}

