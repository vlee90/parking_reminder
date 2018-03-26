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
    init(date: Date, days: [DaysOfWeek], type: ReminderType, entity: NSEntityDescription, context: NSManagedObjectContext) {
        super.init(entity: entity, insertInto: context)
        self.date = date as NSDate!
        var dayArray = [String]()
        for day in days {
            dayArray.append(day.rawValue)
        }
        self.days = dayArray
        self.type = type.rawValue
    }
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    
    func returnDayStatus() -> String {
        let days = convertToEnumDayTo(stringDays: self.days)
        if days.contains(DaysOfWeek.Monday) &&
            days.contains(DaysOfWeek.Tuesday) &&
            days.contains(DaysOfWeek.Wedensday) &&
            days.contains(DaysOfWeek.Thursday) &&
            days.contains(DaysOfWeek.Friday) &&
            !days.contains(DaysOfWeek.Saturday) &&
            !days.contains(DaysOfWeek.Sunday)
        {
            return "Weekdays"
        }
        else if !days.contains(DaysOfWeek.Monday) &&
            !days.contains(DaysOfWeek.Tuesday) &&
            !days.contains(DaysOfWeek.Wedensday) &&
            !days.contains(DaysOfWeek.Thursday) &&
            !days.contains(DaysOfWeek.Friday) &&
            days.contains(DaysOfWeek.Saturday) &&
            days.contains(DaysOfWeek.Sunday) {
            return "Weekends"
        }
        else if days.contains(DaysOfWeek.Monday) &&
            days.contains(DaysOfWeek.Tuesday) &&
            days.contains(DaysOfWeek.Wedensday) &&
            days.contains(DaysOfWeek.Thursday) &&
            days.contains(DaysOfWeek.Friday) &&
            days.contains(DaysOfWeek.Saturday) &&
            days.contains(DaysOfWeek.Sunday) {
            return "Everyday"
        }
        else {
            var dayArray = [String]()
            for day in days {
                dayArray.append(day.rawValue)
            }
            let dayString = dayArray.joined(separator: ", ")
            return dayString
        }
    }
    
    func returnSimpleTime()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let date = self.date as Date
        return dateFormatter.string(from: date)
    }
    
    func convertToEnumDayTo(stringDays: [String]) -> [DaysOfWeek] {
        var dayArray = [DaysOfWeek]()
        for day in stringDays {
            dayArray.append(DaysOfWeek(rawValue: day)!)
        }
        return dayArray
    }
    
    func convertToStringDayFrom(enumDays: [DaysOfWeek]) -> [String] {
        var dayArray = [String]()
        for day in enumDays {
            dayArray.append(day.rawValue)
        }
        return dayArray
    }
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

