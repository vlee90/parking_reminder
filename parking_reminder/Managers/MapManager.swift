//
//  MapManager.swift
//  parking_reminder
//
//  Created by Vincent Lee on 2/20/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit
import MapKit

class MapManager: NSObject {
    
}

extension MapManager: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // If Annotation is User Location, don't modify this annotation.
        if annotation is MKUserLocation {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Church")
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        mapView.removeAnnotation(view.annotation!)
    }
}
