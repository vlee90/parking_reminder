//
//  CreateReminderPickDaysViewController.swift
//  parking_reminder
//
//  Created by Vincent Lee on 3/4/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit

protocol PickedReminderDaysDelegate {
    func didPickReminderDays(days: [DaysOfWeek])
}

class CreateReminderPickDaysViewController: UIViewController {
    @IBOutlet weak var sundayButton: DayButton!
    @IBOutlet weak var mondayButton: DayButton!
    @IBOutlet weak var tuesdayButton: DayButton!
    @IBOutlet weak var wednesdayButton: DayButton!
    @IBOutlet weak var thursdayButton: DayButton!
    @IBOutlet weak var fridayButton: DayButton!
    @IBOutlet weak var saturdayButton: DayButton!
    var reminderType: ReminderType!
    var pickedReminderDaysDelegate: PickedReminderDaysDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Set Days"
        let setTimeBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(selectedDatesPressed))
        navigationItem.setRightBarButton(setTimeBarButtonItem, animated: true)
        view.backgroundColor = UIColor.backgroundSupportColor()
        
        sundayButton.day = DaysOfWeek.Sunday
        mondayButton.day = DaysOfWeek.Monday
        tuesdayButton.day = DaysOfWeek.Tuesday
        wednesdayButton.day = DaysOfWeek.Wedensday
        thursdayButton.day = DaysOfWeek.Thursday
        fridayButton.day = DaysOfWeek.Friday
        saturdayButton.day = DaysOfWeek.Saturday

    }
    
    @objc func selectedDatesPressed() {
        let dayButtons = [sundayButton, mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton,saturdayButton]
        var selectedDays = [DaysOfWeek]()
        for dayButton in dayButtons {
            if dayButton!.isDaySelected {
                selectedDays.append(dayButton!.day!)
            }
        }
        
        if selectedDays.count == 0 {
            let alert = UIAlertController(title: "Waring", message: "Select at least one day.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createReminderPickTimeViewController = storyboard.instantiateViewController(withIdentifier: "CREATE_REMINDER_PICK_TIME_VIEWCONTROLLER") as! CreateReminderPickTimeViewController
        pickedReminderDaysDelegate = createReminderPickTimeViewController
        pickedReminderDaysDelegate.didPickReminderDays(days: selectedDays)
        createReminderPickTimeViewController.reminderType = self.reminderType
        navigationController?.pushViewController(createReminderPickTimeViewController, animated: true)
    }
}

extension CreateReminderPickDaysViewController: PickedReminderTypeDelegate {
    func didPickReminderType(reminderType: ReminderType) {
        self.reminderType = reminderType
    }
}
