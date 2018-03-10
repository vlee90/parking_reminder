//
//  SetReminderTypeButton.swift
//  parking_reminder
//
//  Created by Vincent Lee on 3/9/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit

class SetReminderTypeButton: UIButton {
    var reminderType: ReminderType!
    let reminderText = [ReminderType.SetLocation:"Set Location",
        ReminderType.FindLocation: "Find Location"]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        reminderType = ReminderType.SetLocation
        layer.borderWidth = 1
        layer.cornerRadius = frame.height / 2
        backgroundColor = UIColor.primaryColor()
        setTitleColor(UIColor.black, for: .normal)
        addTarget(self, action: #selector(SetReminderTypeButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        activateButton(type: reminderType)
    }
    
    func activateButton(type: ReminderType) {
        switch type {
        case .FindLocation:
            reminderType = ReminderType.SetLocation
            backgroundColor = UIColor.primaryColor()
        default:
            reminderType = ReminderType.FindLocation
            backgroundColor = UIColor.secondaryColor()
        }
        setTitle(reminderText[reminderType], for: .normal)
    }
}
