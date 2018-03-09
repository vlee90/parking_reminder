//
//  DayButton.swift
//  parking_reminder
//
//  Created by Vincent Lee on 2/21/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit

class DayButton: UIButton {
    var isDaySelected = false
    var day: DaysOfWeek?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderWidth = 3
        self.backgroundColor = UIColor.gray
        self.layer.cornerRadius = 20
        self.setTitleColor(UIColor.black, for: .normal)
        addTarget(self, action: #selector(DayButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        activateButton(bool: !isDaySelected)
    }
    
    func activateButton(bool: Bool) {
        isDaySelected = bool
        backgroundColor = bool ? UIColor.orange : .gray
    }
}
