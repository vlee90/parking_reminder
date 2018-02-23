//
//  SettingViewController.swift
//  parking_reminder
//
//  Created by Vincent Lee on 2/19/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var topTableView: UITableView!
    @IBOutlet weak var bottonTableView: UITableView!
    var topReminders = [Reminder]()
    var bottomReminders = [Reminder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let monday = Reminder(date: Date(), days: [DaysOfWeek.Monday])
        let saturday = Reminder(date: Date(), days: [DaysOfWeek.Saturday])
        let wedensday = Reminder(date: Date(), days: [DaysOfWeek.Wedensday])
        let thursday = Reminder(date: Date(), days: [DaysOfWeek.Thursday])
        
        topReminders = [monday, saturday]
        bottomReminders = [wedensday, thursday]
        
        self.view.backgroundColor = UIColor.blue
        self.topTableView.tag = 0
        self.bottonTableView.tag = 1
        self.topTableView.dataSource = self
        self.bottonTableView.dataSource = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addReminderButtonPressed))
    }
    
    @objc func addReminderButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createVC = storyboard.instantiateViewController(withIdentifier: "createReminderVC") as! CreateReminderViewController
        createVC.reminderCreateionDelegate = self
        self.navigationController?.pushViewController(createVC, animated: true)
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return topReminders.count
        }
        else {
            return bottomReminders.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView.tag == 0) {
            let reminder = topReminders[indexPath.row]
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
            cell.backgroundColor = UIColor.green
//            let components = Calendar.current.dateComponents([.hour, .minute], from: reminder.time)
//            let hour = components.hour!
//            let minute = components.minute!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            let timeString = dateFormatter.string(from: reminder.date)
            let days = reminder.returnDaysAsString()
            let dayStatus = reminder.returnDayStatus()
 
            cell.textLabel?.text = timeString
            cell.detailTextLabel?.text = dayStatus
            return cell
        }
        else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.backgroundColor = UIColor.blue
            cell.textLabel?.text = "Text Label"
            cell.detailTextLabel?.text = "Detail Text Label"
            return cell
        }
    }
}
extension SettingViewController: ReminderCreationDelegate {
    func didCreateReminder(reminder: Reminder) {
        print("Reminder: Date: \(reminder.date) - Days: \(reminder.days)")
        topReminders.append(reminder)
        topTableView.reloadData()
    }
}
