//
//  ParkingSpot+CoreDataClass.swift
//  parking_reminder
//
//  Created by Vincent Lee on 3/26/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//
//

import Foundation
import CoreData
import MapKit

public class ParkingSpot: NSManagedObject {
    init(name: String, latitude: Double, longitude: Double, entity: NSEntityDescription, context: NSManagedObjectContext) {
        super.init(entity: entity, insertInto: context)
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
}

extension ParkingSpot: MKAnnotation {
    public var coordinate: CLLocationCoordinate2D {
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
    
    public var title: String? {
        return name
    }
}
