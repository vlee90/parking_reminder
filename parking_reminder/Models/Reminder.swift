//
//  Reminder.swift
//  parking_reminder
//
//  Created by Vincent Lee on 2/19/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit

class Reminder {
    //  Properties
    var date: Date
    var days: Array<DaysOfWeek>
    let type: ReminderType
    
    //  Init
    init(date: Date, days: Array<DaysOfWeek>, type: ReminderType) {
        self.date = date
        self.days = days
        self.type = type
    }
    
    func returnDayStatus() -> String {
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
            let days = returnDaysAsString()
            let dayString = days.joined(separator: ", ")
            return dayString
        }
    }
    
    func returnDaysAsString() -> Array<String> {
        var dayArray = [String]()
        for day in days {
            switch day {
            case DaysOfWeek.Monday:
                dayArray.append("Monday")
            case DaysOfWeek.Tuesday:
                dayArray.append("Tuesday")
            case DaysOfWeek.Wedensday:
                dayArray.append("Wedensday")
            case DaysOfWeek.Thursday:
                dayArray.append("Thursday")
            case DaysOfWeek.Friday:
                dayArray.append("Friday")
            case DaysOfWeek.Saturday:
                dayArray.append("Saturday")
            case DaysOfWeek.Sunday:
                dayArray.append("Sunday")
            }
        }
        return dayArray
    }
}

enum DaysOfWeek {
    case Monday
    case Tuesday
    case Wedensday
    case Thursday
    case Friday
    case Saturday
    case Sunday
}

enum ReminderType {
    case SetLocation
    case FindLocation
}
