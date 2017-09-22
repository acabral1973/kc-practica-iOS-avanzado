//
//  ActivityExtension.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 21/9/17.
//  Copyright © 2017 KC. All rights reserved.
//

import Foundation

extension Activity{
    
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

