//
//  ExecuteOnceInteractorImpl.swift
//  MadridShops
//
//  Created by Diego Freniche Brito on 18/09/2017.
//  Copyright © 2017 KC. All rights reserved.
//

import Foundation

class ExecuteOnceInteractorImpl: ExecuteOnceInteractor {
    func execute(closure: (String) -> Void) {
        let defaults = UserDefaults.standard
        if let savedData = defaults.string(forKey: "SavedData") {
            switch savedData {
            case "ShopsSaved":
                print("💾 Information about Shops was already downloaded")
                closure("Activities")
            case "ActivitiesSaved":
                print("💾 Information about Activities was already downloaded")
                closure("Shops")
            default:
                print("💾 Information about Shops and Activities was already downloaded")
                closure("Nothing")
            }
        } else {
            closure("All")
        }
    }
}
