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
    let location: CLLocation
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.location = CLLocation(latitude: latitude, longitude: longitude)
    }
}

extension ParkingSpot: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        get {return self.location.coordinate}
    }
    var title: String? {
        get {return self.name}
    }
}
