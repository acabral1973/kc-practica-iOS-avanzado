//
//  MapShops.swift
//  MadridShops
//
//  Created by Diego Freniche Brito on 18/09/2017.
//  Copyright © 2017 KC. All rights reserved.
//

import CoreData
import CoreLocation

func MapShopCDIntoShopAnnotation(shopCD: ShopCD) -> ShopAnnotation {
    let shopLocation = CLLocation(latitude: Double(shopCD.latitude), longitude: Double(shopCD.longitude))
    let shopAnnotation = ShopAnnotation(title: shopCD.name!, subtitle: shopCD.address!, coordinate: shopLocation.coordinate, shop: mapShopCDIntoShop(shopCD: shopCD))

    return shopAnnotation
}

func MapShopAnnotationIntoShop(shopAnnotation: ShopAnnotation) -> Shop {
    let shop : Shop = shopAnnotation.shop
    return shop
}

func mapShopCDIntoShop(shopCD: ShopCD) -> Shop {
    let shop = Shop(name: shopCD.name ?? "Empty")
    shop.address = shopCD.address ?? ""
    shop.image = shopCD.image ?? ""
    shop.logo = shopCD.logo ?? ""
    shop.latitude = shopCD.latitude
    shop.longitude = shopCD.longitude
    shop.description = shopCD.description_en ?? ""
    shop.openingHours = shopCD.openingHours ?? ""
    
    return shop
}

func mapShopIntoShopCD(context: NSManagedObjectContext, shop: Shop) -> ShopCD {
    // mapping shop into ShopCD
    let shopCD = ShopCD(context: context)
    shopCD.name = shop.name
    shopCD.address = shop.address
    shopCD.image = shop.image
    shopCD.logo = shop.logo
    shopCD.latitude = shop.latitude ?? 0.0
    shopCD.longitude = shop.longitude ?? 0.0
    shopCD.description_en = shop.description
    shopCD.openingHours = shop.openingHours
    
    return shopCD
}

