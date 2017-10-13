//
//  ActivityExtensions.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 21/9/17.
//  Copyright © 2017 KC. All rights reserved.
//

import Foundation

extension Activity{

    var activityMapImage : String {
        let activityCoordinate = "\(self.latitude!),\(self.longitude!)"
        let googleMapImage = "https://maps.googleapis.com/maps/api/staticmap?center=" + activityCoordinate +  "&zoom=17&size=320x220&scale=2&markers=%7Ccolor:0x9C7B14%7C" + activityCoordinate
        return googleMapImage
    }
    
    var proxyForEquatableAndComparable : String{
        get{
            return "\(name) \(address)"
        }
    }
}

extension Activity : Equatable{
    public static func ==(lhs: Activity, rhs: Activity) -> Bool {
        return lhs.proxyForEquatableAndComparable == rhs.proxyForEquatableAndComparable
    }
}

extension Activity : Comparable{
    public static func <(lhs: Activity, rhs: Activity) -> Bool {
        return lhs.proxyForEquatableAndComparable < rhs.proxyForEquatableAndComparable
    }
}

extension Activity : Hashable{
    public var hashValue: Int {
        return proxyForEquatableAndComparable.hashValue
    }
}

