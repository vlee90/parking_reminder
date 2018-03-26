//
//  SettingViewController.swift
//  parking_reminder
//
//  Created by Vincent Lee on 2/19/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit
import CoreData

class SettingViewController: UIViewController {
    
    @IBOutlet weak var reminderTableView: UITableView!
    var fetchedRC: NSFetchedResultsController<Reminder>!
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Reminders"
        
        let parentVC = parent as! NavigationViewController
        context = parentVC.objectContext
        
        view.backgroundColor = UIColor.backgroundSupportColor()
        reminderTableView.dataSource = self
        reminderTableView.rowHeight = 100
        reminderTableView.backgroundColor = UIColor.backgroundColor()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addReminderButtonPressed))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let request = Reminder.fetchRequest() as NSFetchRequest<Reminder>
        let sortType = NSSortDescriptor(key: #keyPath(Reminder.type), ascending: true)
        request.sortDescriptors = [sortType]
        do {
            fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context!, sectionNameKeyPath: #keyPath(Reminder.type), cacheName: nil)
            try fetchedRC.performFetch()
            fetchedRC.delegate = self
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    @objc func addReminderButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createReminderPickTypeViewController = storyboard.instantiateViewController(withIdentifier: "CREATE_REMINDER_PICK_TYPE_VIEWCONTROLLER") as! CreateReminderPickTypeViewController
        navigationController?.pushViewController(createReminderPickTypeViewController, animated: true)
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let frc = fetchedRC {
            return frc.sections!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = fetchedRC.sections?[section] else {
            return nil
        }
        let reminderType = ReminderType(rawValue: sectionInfo.name)
        if reminderType == ReminderType.FindLocation {
            return "Find Spot Alerts"
        } else {
            return "Set Spot Alerts"
        }
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
        let reminder = fetchedRC.object(at: indexPath)
        cell.setReminder(reminder: reminder)
        let reminderType = ReminderType(rawValue: reminder.type)!
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
            print("IndexPath: \(indexPath)")
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

extension SettingViewController: ReminderCreationDelegate {
    func didCreateReminder(reminder: Reminder) {
//        let request = Reminder.fetchRequest() as NSFetchRequest<Reminder>
//        let sortType = NSSortDescriptor(key: #keyPath(Reminder.type), ascending: true)
//        request.sortDescriptors = [sortType]
//        do {
//            fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context!, sectionNameKeyPath: #keyPath(Reminder.type), cacheName: nil)
//            try fetchedRC.performFetch()
//            fetchedRC.delegate = self
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
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

