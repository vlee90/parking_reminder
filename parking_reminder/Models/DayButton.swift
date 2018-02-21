//
//  DayButton.swift
//  parking_reminder
//
//  Created by Vincent Lee on 2/21/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit

class DayButton: UIButton {
    var dayPicked = false
    var day: DaysOfWeek?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
