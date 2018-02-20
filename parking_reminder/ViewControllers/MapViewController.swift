//
//  MapViewController.swift
//  parking_reminder
//
//  Created by Vincent Lee on 2/19/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var parkButton: UIButton!
    
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        self.locationManager = CLLocationManager()
        self.locationManager!.delegate = self;
        self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager!.requestWhenInUseAuthorization()
        
        let greenLake = CLLocation(latitude: 47.678596, longitude: -122.324003)
        let regionRadius: CLLocationDistance = 1000
        let region = MKCoordinateRegionMakeWithDistance(greenLake.coordinate, regionRadius, regionRadius)
        
        self.mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true

    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            print("Permission Approved")
            manager.startUpdatingLocation()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
}
