//
//  CreateReminderPickTypeViewController.swift
//  parking_reminder
//
//  Created by Vincent Lee on 3/3/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit

protocol PickedReminderTypeDelegate {
    func didPickReminderType(reminderType: ReminderType)
}

class CreateReminderPickTypeViewController: UIViewController {
    @IBOutlet weak var setLocationButton: UIButton!
    @IBOutlet weak var findLocationButton: UIButton!
    var reminderTypeDelegate: PickedReminderTypeDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Set Type"
        setLocationButton.backgroundColor = UIColor.lightGray
        setLocationButton.layer.cornerRadius = 20
        setLocationButton.layer.borderWidth = 3
        
        findLocationButton.backgroundColor = UIColor.gray
        findLocationButton.layer.cornerRadius = 20
        findLocationButton.layer.borderWidth = 3
    }
    @IBAction func findLocationButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createReminderPickDateViewController = storyboard.instantiateViewController(withIdentifier: "CREATE_REMINDER_PICK_DATE_VIEWCONTROLLER") as! CreateReminderPickDaysViewController
        reminderTypeDelegate = createReminderPickDateViewController
        reminderTypeDelegate.didPickReminderType(reminderType: ReminderType.FindLocation)
        navigationController?.pushViewController(createReminderPickDateViewController, animated: true)
        
    }
    
    @IBAction func setLocationButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createReminderPickDateViewController = storyboard.instantiateViewController(withIdentifier: "CREATE_REMINDER_PICK_DATE_VIEWCONTROLLER") as! CreateReminderPickDaysViewController
        reminderTypeDelegate = createReminderPickDateViewController
        reminderTypeDelegate.didPickReminderType(reminderType: ReminderType.SetLocation)
        navigationController?.pushViewController(createReminderPickDateViewController, animated: true)
    }
}
