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
            print("💾 Las ", key, " ya estaban cargadas en la base de datos")
        } else {
            // first time
            print("💾 Descargando ", key, " por primera vez desde Internet")
            closure()
        }
    }
}
