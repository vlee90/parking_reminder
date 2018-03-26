//
//  CreateReminderPickTimeViewController.swift
//  parking_reminder
//
//  Created by Vincent Lee on 3/4/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit
import CoreData

protocol ReminderCreationDelegate {
    func didCreateReminder(reminder: Reminder)
}

class CreateReminderPickTimeViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    var reminderType: ReminderType!
    var pickedDays: [DaysOfWeek]!
    var createReminderDelegate: ReminderCreationDelegate!
    
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
        let reminder = Reminder(date: datePicker.date, days: pickedDays, type: reminderType, entity: Reminder.entity(), context: context!)
        do {
            try context?.save()
        } catch {
            let err = error as NSError
            fatalError("Unresolved error \(err), \(err.userInfo)")
        }
        let rootViewController = navigationController?.viewControllers.first! as! SettingViewController
        createReminderDelegate = rootViewController
        createReminderDelegate.didCreateReminder(reminder: reminder)
        navigationController?.popToRootViewController(animated: true)
    }
}

extension CreateReminderPickTimeViewController: PickedReminderDaysDelegate {
    func didPickReminderDays(days: [DaysOfWeek]) {
        pickedDays = days
    }
}