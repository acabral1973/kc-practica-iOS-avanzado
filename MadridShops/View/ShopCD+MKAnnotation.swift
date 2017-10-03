//
//  ShopCD+MKAnnotation.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 2/10/17.
//  Copyright © 2017 KC. All rights reserved.
//

import MapKit

extension ShopCD: MKAnnotation {
    public var coordinate: CLLocationCoordinate2D {
        let latDegrees = CLLocationDegrees(latitude)
        let longDegrees = CLLocationDegrees(longitude)
        return CLLocationCoordinate2D(latitude: latDegrees, longitude: longDegrees)
    }
    
    public var title : String? {
        return self.name!
    }
    
    public var subtitle : String? {
        return self.address!
    }
}

