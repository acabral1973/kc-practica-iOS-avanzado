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
    
    init(shopCD: ShopCD){
        self.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(shopCD.latitude), longitude: CLLocationDegrees(shopCD.longitude))
        self.title = shopCD.name!
        self.subtitle = shopCD.address!
    }

}
