//
//  ReminderTableViewCell.swift
//  parking_reminder
//
//  Created by Vincent Lee on 3/2/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    func setReminder(reminder: Reminder) {
        timeLabel.text = reminder.returnSimpleTime()
        daysLabel.text = reminder.returnDayStatus()
        daysLabel.lineBreakMode = .byWordWrapping
        daysLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
