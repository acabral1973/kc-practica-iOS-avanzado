//
//  MapNote.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 28/9/17.
//  Copyright © 2017 KC. All rights reserved.
//

import MapKit

class MapNote: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
