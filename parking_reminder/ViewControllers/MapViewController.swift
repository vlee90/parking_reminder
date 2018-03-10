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
    
    var parkButton: UIButton!
    var locationManager: CLLocationManager!
    var mapManager: MapManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor()
        self.setupLocationManager()
        self.setupMapView()
    }
    
    func setupLocationManager() {
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func setupMapView() {
        parkButton = UIButton(frame: CGRect(x:0, y: mapView.frame.height * 0.85, width: mapView.frame.width + 10, height: mapView.frame.height * 0.1))
//        parkButton.layer.backgroundColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        parkButton.backgroundColor = UIColor(red:0.14, green:0.48, blue:0.63, alpha:0.5)
        
        parkButton.layer.borderWidth = 1
        parkButton.setTitle("Park", for: .normal)
        parkButton.setTitleColor(UIColor.black, for: .normal)
        parkButton.setTitleColor(UIColor.backgroundColor(), for: .highlighted)
        parkButton.setTitle("Parked", for: .highlighted)
        parkButton.addTarget(self, action: #selector(MapViewController.parkButtonPressed), for: UIControlEvents.touchUpInside)
        view.addSubview(parkButton)
        
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
    
    @objc func parkButtonPressed() {
        //  If Location Services are not enabled, display alert to user.
        guard let location = self.locationManager.location else {
            let alert = UIAlertController(title: "Location is not enabled", message: "Please enable location services.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //  Create Parking Spot and add this to map.
        let parkingSpot = ParkingSpot(name: "Parking Sport", latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = parkingSpot.location
        annotation.title = parkingSpot.name
        self.mapView.addAnnotation(annotation)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
        let alert = UIAlertController(title: "An error has occured", message: "Location Services is having difficulties.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alert.addAction(alertAction)
    }
}
