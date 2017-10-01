//
//  ShopsViewController+Map.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 29/9/17.
//  Copyright © 2017 KC. All rights reserved.
//

import CoreLocation
import MapKit

extension ShopsViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func setShopsMap() {
        
        // Inicializo servicios de localización
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.shopsMap.delegate = self
        self.locationManager.startUpdatingLocation()
        
        // Centro el mapa en Madrid y defino una región concreta a su alrededor para su visualización
        let madridLocation = CLLocation(latitude:40.41889 , longitude: -3.69194)
        let madridRegion = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        let reg = self.shopsMap.regionThatFits(madridRegion)
        self.shopsMap.setCenter(madridLocation.coordinate, animated: true)
        self.shopsMap.setRegion(reg, animated: true)
    }
    
    func addMapNote(shopCD: ShopCD) {
        // Inicializo annotation
        let shopCoordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(shopCD.latitude), longitude: CLLocationDegrees(shopCD.longitude))
        let shopAnnotation = MapNote(coordinate: shopCoordinates, title: shopCD.name!, subtitle: shopCD.address!)
        self.shopsMap.addAnnotation(shopAnnotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        // Better to make this class property
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            // annotationView.image = UIImage(named: "marker")
        }
        
        return annotationView
    }

}


