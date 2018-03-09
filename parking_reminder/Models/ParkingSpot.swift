//
//  ParkingSpot.swift
//  parking_reminder
//
//  Created by Vincent Lee on 2/19/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit
import MapKit

class ParkingSpot: NSObject {
    let name: String
    let location: CLLocationCoordinate2D
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
