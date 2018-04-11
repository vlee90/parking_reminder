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
import CoreData

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var parkButton: UIButton!
    var locationManager: CLLocationManager!
    var context: NSManagedObjectContext!
    var fetchRC: NSFetchedResultsController<ParkingSpot>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor()
        let tvc = self.tabBarController as! TabBarViewController
        context = tvc.objectContext
        let request = ParkingSpot.fetchRequest() as NSFetchRequest<ParkingSpot>
        let sortType = NSSortDescriptor(key: #keyPath(ParkingSpot.name), ascending: true)
        request.sortDescriptors = [sortType]
        do {
            fetchRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            try fetchRC.performFetch()
            fetchRC.delegate = self
            if let parkingSpots = fetchRC.fetchedObjects {
                for spot in parkingSpots {
                    mapView.addAnnotation(spot)
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        setupLocationManager()
        setupMapView()

    }
    
    func setupLocationManager() {
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func setupMapView() {
        parkButton = UIButton(frame: CGRect(x:0, y: mapView.frame.height * 0.85, width: mapView.frame.width + 10, height: mapView.frame.height * 0.1))
        parkButton.backgroundColor = UIColor(red:0.14, green:0.48, blue:0.63, alpha:0.5)
        parkButton.setTitle("Park", for: .normal)
        parkButton.setTitleColor(UIColor.black, for: .normal)
        parkButton.setTitleColor(UIColor.backgroundColor(), for: .highlighted)
        parkButton.setTitle("Parked", for: .highlighted)
        parkButton.addTarget(self, action: #selector(MapViewController.parkButtonPressed), for: UIControlEvents.touchUpInside)
        view.addSubview(parkButton)
        
        let greenLake = CLLocation(latitude: 47.678596, longitude: -122.324003)
        let regionRadius: CLLocationDistance = 1000
        let region = MKCoordinateRegionMakeWithDistance(greenLake.coordinate, regionRadius, regionRadius)
    
        mapView.delegate = self
//        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
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
        let parkingSpot = ParkingSpot(name: "Parking Sport", latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, entity: ParkingSpot.entity(), context: context)
        let annotation = MKPointAnnotation()
        annotation.coordinate = parkingSpot.coordinate
        annotation.title = parkingSpot.name
        
        do {
            try context?.save()
        } catch {
            let err = error as NSError
            fatalError("Unresolved error \(err), \(err.userInfo)")
        }
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

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.setCenter(mapView.userLocation.coordinate, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // If Annotation is User Location, don't modify this annotation.
        if annotation is MKUserLocation {
            return nil
        }

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "none")
            annotationView?.animatesDrop = true
            annotationView?.canShowCallout = true
            annotationView?.isDraggable = true
            annotationView?.pinTintColor = .purple
            
            let deleteButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            deleteButton.setTitle("-", for: .normal)
            deleteButton.backgroundColor = UIColor.red
            deleteButton.layer.cornerRadius = 5
            deleteButton.layer.cornerRadius = 1
            deleteButton.layer.borderColor = UIColor.black.cgColor
            annotationView?.rightCalloutAccessoryView = deleteButton
            
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if let userAnnotationView = mapView.view(for: mapView.userLocation) {
            userAnnotationView.isEnabled = false
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let parkingSpot = view.annotation as! ParkingSpot
        context.delete(parkingSpot)
        do {
            try context?.save()
        } catch {
            let err = error as NSError
            fatalError("Unresolved error \(err), \(err.userInfo)")
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        if newState == .ending {
            if let parkingSpot = view.annotation as? ParkingSpot {
                let object = context.object(with: parkingSpot.objectID) as! ParkingSpot
                object.latitude = parkingSpot.latitude
                object.longitude = parkingSpot.longitude
                object.coordinate = parkingSpot.coordinate
                do {
                    try context?.save()
                } catch {
                    let err = error as NSError
                    fatalError("Unresolved error \(err), \(err.userInfo)")
                }
            }
        }
    }
}

extension MapViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let parkingSpot = anObject as? ParkingSpot else {
            preconditionFailure("All changes observed in the map view controller should be for ParkingSpot instances")
        }
        switch type {
        case .insert:
            mapView.addAnnotation(parkingSpot)
        case .delete:
            mapView.removeAnnotation(parkingSpot)
        case .update:
            mapView.removeAnnotation(parkingSpot)
            mapView.addAnnotation(parkingSpot)
        default:
            break
        }
    }
}




