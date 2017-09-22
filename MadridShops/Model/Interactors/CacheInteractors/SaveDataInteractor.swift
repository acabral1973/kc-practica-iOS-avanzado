//
//  SaveDataInteractor.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 22/9/17.
//  Copyright © 2017 KC. All rights reserved.
//

import Foundation
import CoreData

// Definición del protocolo para el interactor que graba las tiendas en disco
protocol SaveAllShopsInteractor {
    // execute: saves all shops. Return on the main thread
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void, onError: errorClosure)
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void)
}

// Definición del protocolo para el interactor que graba las actividades en disco
protocol SaveAllActivitiesInteractor {
    // execute: saves all activities. Return on the main thread
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: @escaping (Activities) -> Void, onError: errorClosure)
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: @escaping (Activities) -> Void)
}
