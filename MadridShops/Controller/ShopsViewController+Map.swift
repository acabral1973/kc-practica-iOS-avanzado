//
//  ShopsViewController+Map.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 29/9/17.
//  Copyright © 2017 KC. All rights reserved.
//

import CoreLocation
import MapKit

extension ShopsViewController {
    
    func setShopsMap() {
                
        // Centro el mapa en Madrid y defino una región concreta a su alrededor para su visualización
        let madridLocation = CLLocation(latitude:40.41889 , longitude: -3.69194)
        let madridRegion = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        let reg = self.shopsMap.regionThatFits(madridRegion)
        self.shopsMap.setCenter(madridLocation.coordinate, animated: true)
        self.shopsMap.setRegion(reg, animated: true)
    }
    
    

 

}


