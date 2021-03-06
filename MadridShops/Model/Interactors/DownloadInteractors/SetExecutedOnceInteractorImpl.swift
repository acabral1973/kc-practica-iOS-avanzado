//
//  SetExecutedOnceInteractorImpl.swift
//  MadridShops
//
//  Created by Diego Freniche Brito on 18/09/2017.
//  Copyright © 2017 KC. All rights reserved.
//

import Foundation

class SetExecutedOnceInteractorImpl: SetExecutedOnceInteractor {
    func execute(key: String) {
        let defaults = UserDefaults.standard
        defaults.set("SAVED", forKey: key)
        defaults.synchronize()
    }
}
