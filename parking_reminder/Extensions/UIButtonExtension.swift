//
//  UIButtonExtension.swift
//  parking_reminder
//
//  Created by Vincent Lee on 4/11/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit

extension UIButton {
    var defaultFont: UIFont? {
        get {return self.titleLabel?.font}
        set {self.titleLabel?.font = UIFont(name: "Courier", size: 20)}
    }
}
