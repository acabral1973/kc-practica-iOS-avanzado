//
//  MapAnnotations.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 2/10/17.
//  Copyright © 2017 KC. All rights reserved.
//

import MapKit

class ShopAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    let shop: Shop
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, shop: Shop) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.shop = shop
    }
}

class ActivityAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    let activity: Activity
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, activity: Activity) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.activity = activity
    }
}

