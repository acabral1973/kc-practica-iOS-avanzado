//
//  SaveDataInteractorImpl.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 22/9/17.
//  Copyright © 2017 KC. All rights reserved.
//

import Foundation
import CoreData

// Implementación del interactor que graba las tiendas en disco
final class SaveAllShopsInteractorImpl: SaveAllShopsInteractor {
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void, onError: errorClosure) {
        
        for i in 0 ..< shops.count() {
            let shop = shops.get(index: i)
            
            let _ = mapShopIntoShopCD(context: context, shop: shop)
        }
        
        do {
            try context.save()
            onSuccess(shops)
        } catch {
            // onError(nil)
        }
    }
    
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void) {
        execute(shops: shops, context: context, onSuccess: onSuccess, onError: nil)
    }
}

// Implementación del interactor que graba las actividades en disco
final class SaveAllActivitiesInteractorImpl: SaveAllActivitiesInteractor {
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: @escaping (Activities) -> Void, onError: errorClosure) {
        
        for i in 0 ..< activities.count() {
            let activity = activities.get(index: i)
            
            let _ = mapActivityIntoActivityCD(context: context, activity: activity)
        }
        
        do {
            try context.save()
            onSuccess(activities)
        } catch {
            // onError(nil)
        }
        
    }
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: @escaping (Activities) -> Void) {
        execute(activities: activities, context: context, onSuccess: onSuccess, onError: nil)
    }
}
