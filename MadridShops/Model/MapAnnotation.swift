//
//  MapAnnotation.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 2/10/17.
//  Copyright © 2017 KC. All rights reserved.
//

import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}

