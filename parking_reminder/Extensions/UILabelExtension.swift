//
//  UILabelExtension.swift
//  parking_reminder
//
//  Created by Vincent Lee on 4/11/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit

extension UILabel {
    var defaultFont: UIFont? {
        get {return self.font}
        set {self.font = UIFont(name: "Courier", size: 20)}
    }
}
