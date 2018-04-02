//
//  ParkingSpot+CoreDataProperties.swift
//  parking_reminder
//
//  Created by Vincent Lee on 3/26/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//
//

import Foundation
import CoreData


extension ParkingSpot {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ParkingSpot> {
        return NSFetchRequest<ParkingSpot>(entityName: "ParkingSpot")
    }

    @NSManaged public var name: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}
