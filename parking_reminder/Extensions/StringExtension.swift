//
//  StringExtension.swift
//  parking_reminder
//
//  Created by Vincent Lee on 4/11/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import Foundation

extension String {
    static func randomNumber(length: Int = 10) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}
