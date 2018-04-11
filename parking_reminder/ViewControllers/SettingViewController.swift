//
//  SettingViewController.swift
//  parking_reminder
//
//  Created by Vincent Lee on 2/19/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class SettingViewController: UIViewController {
    
    @IBOutlet weak var reminderTableView: UITableView!
    var fetchedRC: NSFetchedResultsController<ReminderSet>!
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Reminders"
        
        let parentVC = parent as! NavigationViewController
        context = parentVC.objectContext
        
        view.backgroundColor = UIColor.backgroundSupportColor()
        reminderTableView.dataSource = self
        reminderTableView.delegate = self
        reminderTableView.rowHeight = 100
        reminderTableView.backgroundColor = UIColor.backgroundColor()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addReminderButtonPressed))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let request = ReminderSet.fetchRequest() as NSFetchRequest<ReminderSet>
        let sortType = NSSortDescriptor(key: #keyPath(ReminderSet.type), ascending: true)
        request.sortDescriptors = [sortType]
        do {
            fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context!, sectionNameKeyPath: #keyPath(ReminderSet.type), cacheName: nil)
            try fetchedRC.performFetch()
            fetchedRC.delegate = self
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    @objc func addReminderButtonPressed() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if !granted {
                let alert = UIAlertController(title: "Warning", message: "Push Notifications must be enabled to schedule alerts.", preferredStyle: UIAlertControllerStyle.alert)
                let alertAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createReminderPickTypeViewController = storyboard.instantiateViewController(withIdentifier: "CREATE_REMINDER_PICK_TYPE_VIEWCONTROLLER") as! CreateReminderPickTypeViewController
        self.navigationController?.pushViewController(createReminderPickTypeViewController, animated: true)
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let frc = fetchedRC {
            return frc.sections!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "REMINDER_HEADER_CELL") as! ReminderHeaderCell
        guard let sectionInfo = fetchedRC.sections?[section] else {
            return nil
        }
        cell.contentView.backgroundColor = UIColor.red
        let reminderType = ReminderType(rawValue: sectionInfo.name)
        if reminderType == ReminderType.FindLocation {
            cell.headerTitle.text = "Find Location Reminders"
        } else {
            cell.headerTitle.text = "Set Location Reminders"
        }
        return cell.contentView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedRC.sections else{
            fatalError("No results in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "REMINDER_TABLEVIEW_CELL") as! ReminderTableViewCell
        let reminders = fetchedRC.object(at: indexPath)
        cell.setReminders(reminders: reminders)
        
        let reminderType = ReminderType(rawValue: reminders.type)!
        if reminderType == .FindLocation {
            cell.backgroundColor = UIColor.secondaryColor()
        } else {
            cell.backgroundColor = UIColor.supportColor()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let reminder = fetchedRC.object(at: indexPath)
            context.delete(reminder)
            do {
                try context.save()
            } catch {
                let err = error as NSError
                fatalError("Unresolved error \(err), \(err.userInfo)")
            }
        }
    }
}

extension SettingViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        let index = indexPath ?? (newIndexPath ?? nil)
        guard let cellIndex = index else {return}
        switch type {
        case .insert:
            reminderTableView.insertRows(at: [cellIndex], with: .none)
        case .delete:
            reminderTableView.deleteRows(at: [cellIndex], with: .none)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet.init(integer: sectionIndex)
        switch type {
        case .insert:
            reminderTableView.insertSections(indexSet, with: .none)
        case .delete:
            reminderTableView.deleteSections(indexSet, with: .none)
        default:
            break
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        reminderTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        reminderTableView.endUpdates()
    }
}

