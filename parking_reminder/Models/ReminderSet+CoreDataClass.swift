//
//  ReminderSet+CoreDataClass.swift
//  parking_reminder
//
//  Created by Vincent Lee on 4/11/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//
//

import Foundation
import CoreData


public class ReminderSet: NSManagedObject {
    func returnSimpleTime()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let components = DateComponents(calendar: nil, timeZone: nil, era: nil, year: nil, month: nil, day: nil, hour: Int(hour), minute: Int(minute), second: nil, nanosecond: nil, weekday: Int(day), weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        let date = dateFormatter.calendar.date(from: components)
        return dateFormatter.string(from: date!)
    }

    
    
    func returnDayStatus() -> String {
        var days = [DaysOfWeek]()
        for case let reminder as Reminder in reminders {
            if let dayOfWeek = reminder.returnDayOfWeek() {
                days.append(dayOfWeek)
            }
        }
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
}
