//
//  SettingViewController.swift
//  parking_reminder
//
//  Created by Vincent Lee on 2/19/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var reminderTableView: UITableView!
    var topReminders = [Reminder]()
    var bottomReminders = [Reminder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Reminders"
        let monday = Reminder(date: Date(), days: [DaysOfWeek.Monday], type: ReminderType.FindLocation)
        let saturday = Reminder(date: Date(), days: [DaysOfWeek.Saturday], type: ReminderType.SetLocation)
        let wedensday = Reminder(date: Date(), days: [DaysOfWeek.Wedensday], type: ReminderType.FindLocation)
        let thursday = Reminder(date: Date(), days: [DaysOfWeek.Thursday], type: ReminderType.SetLocation)
        
        topReminders = [monday, saturday]
        bottomReminders = [wedensday, thursday]
        
        view.backgroundColor = UIColor.blue
        reminderTableView.dataSource = self
        reminderTableView.rowHeight = 100
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addReminderButtonPressed))
    }
    
    @objc func addReminderButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createReminderPickTypeViewController = storyboard.instantiateViewController(withIdentifier: "CREATE_REMINDER_PICK_TYPE_VIEWCONTROLLER") as! CreateReminderPickTypeViewController
        navigationController?.pushViewController(createReminderPickTypeViewController, animated: true)
    }
}

extension SettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Set Location Reminders"
        } else {
            return "Find Locaiton Reminders"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return topReminders.count
        } else {
            return bottomReminders.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let reminder = topReminders[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "REMINDER_TABLEVIEW_CELL") as! ReminderTableViewCell
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            let timeString = dateFormatter.string(from: reminder.date)
            let dayStatus = reminder.returnDayStatus()
            
            cell.timeLabel?.text = timeString
            cell.daysLabel?.text = dayStatus
            cell.daysLabel.lineBreakMode = .byWordWrapping
            cell.daysLabel.numberOfLines = 0
            return cell
        } else {
            let reminder = bottomReminders[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "REMINDER_TABLEVIEW_CELL") as! ReminderTableViewCell
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            let timeString = dateFormatter.string(from: reminder.date)
            let dayStatus = reminder.returnDayStatus()
            
            cell.timeLabel?.text = timeString
            cell.daysLabel?.text = dayStatus
            cell.daysLabel.lineBreakMode = .byWordWrapping
            cell.daysLabel.numberOfLines = 0
            return cell
        }
       
    }
}

extension SettingViewController: ReminderCreationDelegate {
    func didCreateReminder(reminder: Reminder) {
        print("Reminder: Date: \(reminder.date) - Days: \(reminder.days)")
        topReminders.append(reminder)
        reminderTableView.reloadData()
    }
}

