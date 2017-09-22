//
//  ExecuteOnceInteractorImpl.swift
//  MadridShops
//
//  Created by Diego Freniche Brito on 18/09/2017.
//  Copyright © 2017 KC. All rights reserved.
//

import Foundation

class ExecuteOnceInteractorImpl: ExecuteOnceInteractor {
    func execute(key: String, closure: () -> Void) {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: key) {
            // already saved
        } else {
            // first time
            closure()
        }
    }
}
