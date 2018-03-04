//
//  CreateReminderViewController.swift
//  parking_reminder
//
//  Created by Vincent Lee on 2/20/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit

protocol ReminderCreationDelegate {
    func didCreateReminder(reminder: Reminder)
}

class CreateReminderViewController: UIViewController {
    @IBOutlet weak var sundayButton: DayButton!
    @IBOutlet weak var mondayButton: DayButton!
    @IBOutlet weak var tuesdayButton: DayButton!
    @IBOutlet weak var wednesdayButton: DayButton!
    @IBOutlet weak var thursdayButton: DayButton!
    @IBOutlet weak var fridayButton: DayButton!
    @IBOutlet weak var saturdayButton: DayButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var setReminderTypeButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var setLocationLabel: UILabel!
    @IBOutlet weak var findLocationLabel: UILabel!
    
    var reminderCreateionDelegate: ReminderCreationDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.yellow
        createButton.backgroundColor = UIColor.black
        createButton.layer.cornerRadius = 0.15 * createButton.bounds.size.width
        
        sundayButton.backgroundColor = UIColor.gray
        sundayButton.layer.cornerRadius = 0.5 * sundayButton.bounds.size.width
        sundayButton.day = DaysOfWeek.Sunday
        mondayButton.backgroundColor = UIColor.gray
        mondayButton.layer.cornerRadius = 0.5 * mondayButton.bounds.size.width
        mondayButton.day = DaysOfWeek.Monday
        tuesdayButton.backgroundColor = UIColor.gray
        tuesdayButton.layer.cornerRadius = 0.5 * tuesdayButton.bounds.size.width
        tuesdayButton.day = DaysOfWeek.Tuesday
        wednesdayButton.backgroundColor = UIColor.gray
        wednesdayButton.layer.cornerRadius = 0.5 * wednesdayButton.bounds.size.width
        wednesdayButton.day = DaysOfWeek.Wedensday
        thursdayButton.backgroundColor = UIColor.gray
        thursdayButton.layer.cornerRadius = 0.5 * thursdayButton.bounds.size.width
        thursdayButton.day = DaysOfWeek.Thursday
        fridayButton.backgroundColor = UIColor.gray
        fridayButton.layer.cornerRadius = 0.5 * fridayButton.bounds.size.width
        fridayButton.day = DaysOfWeek.Friday
        saturdayButton.backgroundColor = UIColor.gray
        saturdayButton.layer.cornerRadius = 0.5 * saturdayButton.bounds.size.width
        saturdayButton.day = DaysOfWeek.Saturday
    }
    @IBAction func sundayButtonPressed(_ sender: Any) {
        if sundayButton.dayPicked {
            sundayButton.dayPicked = false
            sundayButton.backgroundColor = UIColor.gray
        }
        else {
            sundayButton.dayPicked = true
            sundayButton.backgroundColor = UIColor.orange
        }
    }
    @IBAction func mondayButtonPressed(_ sender: Any) {
        if mondayButton.dayPicked {
            mondayButton.dayPicked = false
            mondayButton.backgroundColor = UIColor.gray
        }
        else {
            mondayButton.dayPicked = true
            mondayButton.backgroundColor = UIColor.orange
        }
    }
    @IBAction func tuesdayButtonPressed(_ sender: Any) {
        if tuesdayButton.dayPicked {
            tuesdayButton.dayPicked = false
            tuesdayButton.backgroundColor = UIColor.gray
        }
        else {
            tuesdayButton.dayPicked = true
            tuesdayButton.backgroundColor = UIColor.orange
        }
    }
    @IBAction func wednesdayButtonPressed(_ sender: Any) {
        if wednesdayButton.dayPicked {
            wednesdayButton.dayPicked = false
            wednesdayButton.backgroundColor = UIColor.gray
        }
        else {
            wednesdayButton.dayPicked = true
            wednesdayButton.backgroundColor = UIColor.orange
        }
    }
    @IBAction func thursdayButtonPressed(_ sender: Any) {
        if thursdayButton.dayPicked {
            thursdayButton.dayPicked = false
            thursdayButton.backgroundColor = UIColor.gray
        }
        else {
            thursdayButton.dayPicked = true
            thursdayButton.backgroundColor = UIColor.orange
        }
    }
    @IBAction func fridayButtonPressed(_ sender: Any) {
        if fridayButton.dayPicked {
            fridayButton.dayPicked = false
            fridayButton.backgroundColor = UIColor.gray
        }
        else {
            fridayButton.dayPicked = true
            fridayButton.backgroundColor = UIColor.orange
        }
    }
    @IBAction func saturdayButtonPressed(_ sender: Any) {
        if saturdayButton.dayPicked {
            saturdayButton.dayPicked = false
            saturdayButton.backgroundColor = UIColor.gray
        }
        else {
            saturdayButton.dayPicked = true
            saturdayButton.backgroundColor = UIColor.orange
        }
    }
    
    @IBAction func setReminderTypeButtonPressed(_ sender: Any) {
        if setLocationLabel.isEnabled {
            setLocationLabel.isEnabled = false
            findLocationLabel.isEnabled = true
        } else {
            setLocationLabel.isEnabled = true
            findLocationLabel.isEnabled = false
        }
    }
    
    @IBAction func createButtonPressed(_ sender: Any) {
        let dayButtons = [sundayButton, mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton,saturdayButton]
        var selectedDays = [DaysOfWeek]()
        for dayButton in dayButtons {
            if dayButton!.dayPicked {
                selectedDays.append(dayButton!.day!)
            }
        }
        let date = datePicker.date
        
        var reminderType: ReminderType
        if setLocationLabel.isEnabled {
            reminderType = ReminderType.SetLocation
        } else {
            reminderType = ReminderType.FindLocation
        }
        
        let reminder = Reminder(date: date, days: selectedDays, type: reminderType)
        reminderCreateionDelegate.didCreateReminder(reminder: reminder)
        self.navigationController?.popViewController(animated: true)
    }
    
}
