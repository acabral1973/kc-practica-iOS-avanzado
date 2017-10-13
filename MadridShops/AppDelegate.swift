//
//  AppDelegate.swift
//  MadridShops
//
//  Created by Diego Freniche Brito on 07/09/2017.
//  Copyright © 2017 KC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Ajusto el estilo de la statusBar
        UIApplication.shared.statusBarStyle = .lightContent
        
        return true
    }


    func applicationDidEnterBackground(_ application: UIApplication) {
        // guard let context = self.context else { return }
        // self.cds.saveContext(context: context)
    }
}

