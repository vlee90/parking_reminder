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
    var time: Date
    var days: Array<String>
    
    //  Init
    init(time: Date, days: Array<String>) {
        self.time = time
        self.days = days
    }
    
}
