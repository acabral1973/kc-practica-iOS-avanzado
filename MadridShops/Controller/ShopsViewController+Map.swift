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
  
    // Inicializo los servicios de localización, centro el mapa en Madrid y defino la región que se visualiza
    func setShopsMap() {

        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self as CLLocationManagerDelegate
        self.shopsMap.delegate = self
        self.locationManager.startUpdatingLocation()
        
        let madridLocation = CLLocation(latitude:40.41889 , longitude: -3.69194)
        let madridRegion = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        let reg = self.shopsMap.regionThatFits(madridRegion)
        self.shopsMap.setCenter(madridLocation.coordinate, animated: true)
        self.shopsMap.setRegion(reg, animated: true)
    }
    
    // Cargo annotations en el Mapa
    func addShopsAnnotations() {
        for shopCD in self.fetchedResultsController.fetchedObjects! {
            self.shopsMap.addAnnotation(shopCD)
        }
    }
    
    // Delegados de MapView y LocationManager

    private func mapView(_ mapView: MKMapView, viewFor annotation: ShopCD) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation as MKAnnotation is MKUserLocation) else {
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
            annotationView.image = UIImage(named: "moreInfo")
        }
        
        return annotationView
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        self.shopsMap.setCenter(location.coordinate, animated: true)
    }
    
}
