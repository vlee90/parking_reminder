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
    var mapManager: MapManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupLocationManager()
        self.setupMapView()
    }
    
    func setupLocationManager() {
        self.locationManager = CLLocationManager()
        self.locationManager!.delegate = self;
        self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager!.requestWhenInUseAuthorization()
    }
    
    func setupMapView() {
        let starbucksParking = ParkingSpot(name: "Starbucks", latitude: 47.679992, longitude: -122.325455)
        let churchParking = ParkingSpot(name: "Church", latitude: 47.674954, longitude: -122.320069)
        let greenLake = CLLocation(latitude: 47.678596, longitude: -122.324003)
        let regionRadius: CLLocationDistance = 1000
        let region = MKCoordinateRegionMakeWithDistance(greenLake.coordinate, regionRadius, regionRadius)
    
        let annotation1 = MKPointAnnotation()
        let annotation2 = MKPointAnnotation()
        
        annotation1.coordinate = starbucksParking.location
        annotation1.title = starbucksParking.name
        annotation2.coordinate = churchParking.location
        annotation2.title = churchParking.name
        
        mapManager = MapManager()
        mapView.delegate = mapManager
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        mapView.addAnnotations([annotation1, annotation2])

    }
    
    @IBAction func parkButtonPressed(_ sender: Any) {
        let parkingSpot = ParkingSpot(name: "Parking Sport", latitude: self.locationManager!.location!.coordinate.latitude, longitude: self.locationManager!.location!.coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = parkingSpot.location
        annotation.title = parkingSpot.name
        self.mapView.addAnnotation(annotation)
        
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
        print("ErrorLocalizedDescription: \(error.localizedDescription)")
    }
}
