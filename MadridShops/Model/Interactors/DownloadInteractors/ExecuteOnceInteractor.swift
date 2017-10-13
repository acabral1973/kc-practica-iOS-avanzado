//
//  ExecuteOnce.swift
//  MadridShops
//
//  Created by Diego Freniche Brito on 18/09/2017.
//  Copyright © 2017 KC. All rights reserved.
//

import Foundation

protocol ExecuteOnceInteractor {
    
    // Agrego el parámetro key para poder controlar por separado la descarga de tiendas y de actividades
    // utilizando claves independientes para una y otra descarga
    // De esta forma si una descarga va mal, pero la otra acaba ok, solo repito la que acabó mal
    
    func execute(closure: (String) -> Void)
}
