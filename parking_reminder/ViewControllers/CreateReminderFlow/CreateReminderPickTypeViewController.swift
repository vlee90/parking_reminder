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
    @IBOutlet weak var reminderLabel: UILabel!
    @IBOutlet weak var reminderTypeButton: SetReminderTypeButton!
    
    var reminderTypeDelegate: PickedReminderTypeDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Set Type"
        let setTimeBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(CreateReminderPickTypeViewController.typeSelected))
        navigationItem.setRightBarButton(setTimeBarButtonItem, animated: true)
        view.backgroundColor = UIColor.backgroundColor()
        reminderLabel.backgroundColor = UIColor.supportColor()
        reminderLabel.layer.borderWidth = 1
        reminderLabel.layer.cornerRadius = reminderLabel.frame.height / 4
        reminderLabel.layer.masksToBounds = true
    }
    
    @objc func typeSelected() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createReminderPickDateViewController = storyboard.instantiateViewController(withIdentifier: "CREATE_REMINDER_PICK_DATE_VIEWCONTROLLER") as! CreateReminderPickDaysViewController
        reminderTypeDelegate = createReminderPickDateViewController
        reminderTypeDelegate.didPickReminderType(reminderType: reminderTypeButton.reminderType)
        navigationController?.pushViewController(createReminderPickDateViewController, animated: true)

    }
    
    @IBAction func setLocationButtonPressed(_ sender: Any) {
        if reminderTypeButton.reminderType == ReminderType.SetLocation {
            reminderLabel.text = "Remind me when to set a parking location."
        } else {
            reminderLabel.text = "Remind me where I parked."
        }
    }
}

