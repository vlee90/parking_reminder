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
extension UILabel {
    var defaultFont: UIFont? {
        get {return self.font}
        set {self.font = UIFont(name: "Courier", size: 20)}
    }
}

extension UIColor {
    class func primaryColor() -> UIColor {
        return UIColor(red:1.00, green:0.09, blue:0.33, alpha:1.0)
    }
    class func secondaryColor() -> UIColor {
        return UIColor(red:0.95, green:1.00, blue:0.74, alpha:1.0)
    }
    class func supportColor() -> UIColor {
        return UIColor(red:0.70, green:0.86, blue:0.75, alpha:1.0)
    }
    class func backgroundColor() -> UIColor {
        return UIColor(red:0.44, green:0.76, blue:0.70, alpha:1.0)
    }
    class func backgroundSupportColor() -> UIColor {
        return UIColor(red:0.14, green:0.48, blue:0.63, alpha:1.0)
    }
}
