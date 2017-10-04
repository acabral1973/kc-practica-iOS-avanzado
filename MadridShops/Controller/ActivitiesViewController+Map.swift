//
//  ActivitiesViewController+Map.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 4/10/17.
//  Copyright © 2017 KC. All rights reserved.
//

import CoreLocation
import MapKit

extension ActivitiesViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    // Inicializo los servicios de localización, centro el mapa en Madrid y defino la región que se visualiza
    func setActivitiesMap() {
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.activitiesMap.delegate = self
        self.locationManager.startUpdatingLocation()
        
        let madridLocation = CLLocation(latitude:40.41889 , longitude: -3.69194)
        let madridRegion = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        let reg = self.activitiesMap.regionThatFits(madridRegion)
        self.activitiesMap.setCenter(madridLocation.coordinate, animated: true)
        self.activitiesMap.setRegion(reg, animated: true)
    }
    
    // Cargo annotations en el Mapa
    func addActivitiesAnnotations() {
        for activityCD in self.fetchedResultsController.fetchedObjects! {
            let activityAnnotation = MapActivityCDIntoActivityAnnotation(activityCD: activityCD)
            self.activitiesMap.addAnnotation(activityAnnotation)
        }
    }
    
    // Delegados de MapView y LocationManager
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ActivityAnnotation {
            let annotationIdentifier = "ActivityAnnotationIdentifier"
            var annotationView: MKPinAnnotationView?
            if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
                as? MKPinAnnotationView {
                annotationView = dequeuedAnnotationView
                annotationView?.annotation = annotation
            } else {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            }
            
            if let annotationView = annotationView {
                annotationView.canShowCallout = true
                annotationView.image = UIImage(named: "madrid-shops-logo")
                annotationView.calloutOffset = CGPoint(x: -5, y: 5)
                annotationView.rightCalloutAccessoryView = UIButton(type: .infoDark) as UIView
                let activityNameTextView = UITextView()
                activityNameTextView.text = annotation.activity.name
                
                annotationView.leftCalloutAccessoryView = activityNameTextView
                
            }
            
            return annotationView
        }
        return nil
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            performSegue(withIdentifier: "ShowActivityDetailSegue", sender: MapActivityAnnotationIntoActivity(activityAnnotation: view.annotation as! ActivityAnnotation))
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
}

