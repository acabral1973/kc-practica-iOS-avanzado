//
//  ShopExtrensions.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 13/10/17.
//  Copyright © 2017 KC. All rights reserved.
//

extension Shop {
    
    var shopMapImage : String {
        let shopCoordinate = "\(self.latitude!),\(self.longitude!)"
        let googleMapImage = "https://maps.googleapis.com/maps/api/staticmap?center=" + shopCoordinate +  "&zoom=17&size=320x220&scale=2&markers=%7Ccolor:0x9C7B14%7C" + shopCoordinate
        return googleMapImage
    }
}
