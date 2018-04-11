//
//  UIColorExtension.swift
//  parking_reminder
//
//  Created by Vincent Lee on 4/11/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit

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
