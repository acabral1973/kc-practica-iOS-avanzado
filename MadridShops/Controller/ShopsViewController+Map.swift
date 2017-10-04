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
        self.locationManager.delegate = self
        self.shopsMap.delegate = self
        self.locationManager.startUpdatingLocation()
        
        let madridLocation = CLLocation(latitude:40.41889 , longitude: -3.69194)
        let madridRegion = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        let reg = self.shopsMap.regionThatFits(madridRegion)
        self.shopsMap.setCenter(madridLocation.coordinate, animated: true)
        self.shopsMap.setRegion(reg, animated: true)
    }
    
    // Cargo annotations en el Mapa
    func addShopsAnnotations() {
        for shopCD in self.fetchedResultsController.fetchedObjects! {
            let shopAnnotation = MapShopCDIntoShopAnnotation(shopCD: shopCD)
            self.shopsMap.addAnnotation(shopAnnotation)
        }
    }
    
    // Delegados de MapView y LocationManager
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ShopAnnotation {
            let annotationIdentifier = "ShopAnnotationIdentifier"
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
                
                //let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: annotationView.frame.height, height: annotationView.frame.height))
                //annotation.shop.logo.loadImage(into: imageView)
                //imageView.contentMode = .scaleAspectFit
                let shopNameTextView = UITextView()
                shopNameTextView.text = annotation.shop.name
                
                annotationView.leftCalloutAccessoryView = shopNameTextView
                
            }
            
            return annotationView
        }
        return nil
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            
            print("🔍 Showing detail for: \(view.annotation?.title!)")
            performSegue(withIdentifier: "ShowShopDetailSegue", sender: MapShopAnnotationIntoShop(shopAnnotation: view.annotation as! ShopAnnotation))
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    }
    
}
