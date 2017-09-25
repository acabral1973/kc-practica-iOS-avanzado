//
//  AppDelegate.swift
//  MadridShops
//
//  Created by Diego Freniche Brito on 07/09/2017.
//  Copyright © 2017 KC. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var cds = CoreDataStack()
    var context: NSManagedObjectContext?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.context = cds.createContainer(dbName: "MadridShops").viewContext
        
        // Obtengo mi rootViewController que se que es un TabBar
        let tabBar = self.window?.rootViewController as! UITabBarController
        
        // Obtengo cada ViewController del TabBar que se que son Navigations
        let shopNavigation = tabBar.viewControllers![0] as! UINavigationController
        let activityNavigation = tabBar.viewControllers![1] as! UINavigationController
        
        // Obtengo el topViewController de cada Navigation
        let mainShopVC = shopNavigation.topViewController as! ShopsViewController
        let mainActivityVC = activityNavigation.topViewController as! ActivitiesViewController

        // Le paso el contexto a los viewController de Shops y Activities
        mainShopVC.context = self.context
        mainActivityVC.context = self.context
        
        return true
    }


    func applicationDidEnterBackground(_ application: UIApplication) {
        guard let context = self.context else { return }
        self.cds.saveContext(context: context)
    }
}

