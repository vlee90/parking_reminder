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
        if annotation is MKUserLocation {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "") as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Church")
        } else {
            annotationView?.annotation = annotation
        }
        
        let deleteButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        deleteButton.setTitle("-", for: .normal)
        deleteButton.backgroundColor = UIColor.red
        deleteButton.layer.cornerRadius = 5
        deleteButton.layer.cornerRadius = 1
        deleteButton.layer.borderColor = UIColor.black.cgColor
        
        annotationView?.canShowCallout = true
        annotationView?.rightCalloutAccessoryView = deleteButton
        annotationView?.prepareForDisplay()
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let title = view.annotation!.title!
        print("Select - Title: \(title!)")
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        let title = view.annotation!.title!
        print("Deselect - Title: \(title!)")
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let title = view.annotation!.title!
        print("Callout - Title: \(title!)")
        mapView.removeAnnotation(view.annotation!)
    }
}
