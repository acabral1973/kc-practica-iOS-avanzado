//
//  Activity.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 21/9/17.
//  Copyright © 2017 KC. All rights reserved.
//

import Foundation

public final class Activity {
    var name: String
    var description: String = ""
    var latitude: Float? = nil
    var longitude: Float? = nil
    var image: String = ""
    var logo: String = ""
    var openingHours: String = ""
    var address: String = ""
    
    public init(name: String) {
        self.name = name
    }
}
