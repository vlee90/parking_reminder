//
//  CreateReminderPickTimeViewController.swift
//  parking_reminder
//
//  Created by Vincent Lee on 3/4/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class CreateReminderPickTimeViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    var reminderType: ReminderType!
    var pickedDays: [DaysOfWeek]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Set Time"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(createReminder))
        view.backgroundColor = UIColor.backgroundColor()
        datePicker.backgroundColor = UIColor.secondaryColor()
        datePicker.layer.borderWidth = 1
        
    }
    
    @objc func createReminder() {
        let parentVC = parent as! NavigationViewController
        let context = parentVC.objectContext
        
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        if reminderType.rawValue == "SetLocation" {
            content.title = "Set Parking Location"
            content.body = "A reminder to set your parking location."
        } else {
            content.title = "Find Parking Location"
            content.body = "A reminder to find your parking location."
        }
        content.sound = UNNotificationSound.default()
        let reminderSet = ReminderSet(entity: ReminderSet.entity(), insertInto: context!)
        for day in pickedDays {
            var components = datePicker.calendar.dateComponents([.hour, .minute], from: datePicker.date)
            switch day {
            case .Sunday:
                components.weekday = 1
            case .Monday:
                components.weekday = 2
            case .Tuesday:
                components.weekday = 3
            case .Wedensday:
                components.weekday = 4
            case .Thursday:
                components.weekday = 5
            case .Friday:
                components.weekday = 6
            case .Saturday:
                components.weekday = 7
            }
            let reminder = Reminder(day: components.weekday!, hour: components.hour!, minute: components.minute!, type: reminderType, entity: Reminder.entity(), context: context!)
            reminderSet.day = Int16(components.weekday!)
            reminderSet.hour = Int16(components.hour!)
            reminderSet.minute = Int16(components.minute!)
            reminderSet.type = reminderType.rawValue
            reminderSet.addToReminders(reminder)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            let request = UNNotificationRequest(identifier: reminder.identifier, content: content, trigger: trigger)
            print(request)
            center.add(request) { (error) in
                if let err = error {
                    print("Error: \(err): \(err.localizedDescription)")
                }
            }
        }
        
        do {
            try context?.save()
        } catch {
            let err = error as NSError
            fatalError("Unresolved error \(err), \(err.userInfo)")
        }
        navigationController?.popToRootViewController(animated: true)
    }
}

extension CreateReminderPickTimeViewController: PickedReminderDaysDelegate {
    func didPickReminderDays(days: [DaysOfWeek]) {
        pickedDays = days
    }
}
