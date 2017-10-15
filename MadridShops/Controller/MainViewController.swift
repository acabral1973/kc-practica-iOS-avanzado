//
//  MainViewController.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 5/10/17.
//  Copyright © 2017 KC. All rights reserved.
//

import UIKit
import CoreData
import ReachabilitySwift


class MainViewController: UIViewController {
    
    var cds = CoreDataStack()
    var context: NSManagedObjectContext?
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var msgActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.context = cds.createContainer(dbName: "MadridShops").viewContext
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.msgLabel.textColor = UIColor.black
        self.msgLabel.text = "Sincronizing data from Internet"
        // La descarga de tiendas y actividades se efectúa por separado y solo si no habían sido
        // ejecutadas correctamente anteriormente
        ExecuteOnceInteractorImpl().execute { (to) in
            self.initializeData(type: to, closure: self.initializeShopsAndActivitiesTabBar)
        }
    }
    
    func initializeData(type: String, closure: @escaping () -> Void) {
        
        let reachability = Reachability()!
        
        switch type {
        case "Activities":
            if !(reachability.isReachable) {
                print("No Internet connection available. You only will see shops information")
                self.msgLabel.textColor = UIColor.red
                self.msgLabel.text = "No Internet connection available. You only will see shops information"
            } else {
                // Descargo la info de todas las Actividades
                let downloadActivitiesInteractor: DownloadAllActivitiesInteractor = DownloadAllActivitiesInteractorNSURLSessionImpl()
                downloadActivitiesInteractor.execute { (activities: Activities) in
                    print("👍 Total actividades descargadas: \(activities.count())")
                    let cacheInteractor = SaveAllActivitiesInteractorImpl()
                    cacheInteractor.execute(activities: activities, context: self.context!, onSuccess: { (activities: Activities) in
                        SetExecutedOnceInteractorImpl().execute(key : "ActivitiesSaved")
                        closure()
                    })
                }
            }
        case "Shops":
            if !(reachability.isReachable) {
                print("No Internet connection available. You only will see activities information")
                self.msgLabel.textColor = UIColor.red
                self.msgLabel.text = "No Internet connection available. You only will see activities information"
            } else {
                // Descargo la info de todas las tiendas
                let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsInteractorNSURLSessionImpl()
                downloadShopsInteractor.execute { (shops: Shops) in
                    print("👍 Total tiendas descargadas: \(shops.count())")
                    let cacheInteractor = SaveAllShopsInteractorImpl()
                    cacheInteractor.execute(shops: shops, context: self.context!, onSuccess: { (shops: Shops) in
                        SetExecutedOnceInteractorImpl().execute(key : "ShopsSaved")
                        closure()
                    })
                }
            }
        case "All":
            while !(reachability.isReachable) {
                print("Please verify your Internet connection, we need download information about shops and activities")
                self.msgLabel.textColor = UIColor.red
                self.msgLabel.text = "Please verify your Internet connection, we need download information about shops and activities"
            }
            // Descargo la info de todas las Actividades
            let downloadActivitiesInteractor: DownloadAllActivitiesInteractor = DownloadAllActivitiesInteractorNSURLSessionImpl()
            downloadActivitiesInteractor.execute { (activities: Activities) in
                print("👍 Total actividades descargadas: \(activities.count())")
                let cacheInteractor = SaveAllActivitiesInteractorImpl()
                cacheInteractor.execute(activities: activities, context: self.context!, onSuccess: { (activities: Activities) in
                    SetExecutedOnceInteractorImpl().execute(key : "ActivitiesSaved")
                    
                    // Descargo la info de todas las tiendas
                    let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsInteractorNSURLSessionImpl()
                    downloadShopsInteractor.execute { (shops: Shops) in
                        print("👍 Total tiendas descargadas: \(shops.count())")
                        let cacheInteractor = SaveAllShopsInteractorImpl()
                        cacheInteractor.execute(shops: shops, context: self.context!, onSuccess: { (shops: Shops) in
                            SetExecutedOnceInteractorImpl().execute(key : "ShopsSaved")
                            closure()
                        })
                    }
                })
            }
        default:
            closure()
        }
    }
    
    func initializeShopsAndActivitiesTabBar() {
        
        // Obtengo el TabBar de Shops y Activities del StoryBoard
        let tabBarVC : UITabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        
        // Obtengo cada ViewController del TabBar que se que son Navigations
        let shopNavigation = tabBarVC.viewControllers![0] as! UINavigationController
        let activityNavigation = tabBarVC.viewControllers![1] as! UINavigationController
        
        // Obtengo el topViewController de cada Navigation
        let mainShopVC = shopNavigation.topViewController as! ShopsViewController
        let mainActivityVC = activityNavigation.topViewController as! ActivitiesViewController
        
        // Le paso el contexto a los viewController de Shops y Activities
        mainShopVC.context = self.context
        mainActivityVC.context = self.context
        
        // Presento el TabBar de Shops y Activities
        //self.present(tabBarVC, animated: false, completion: nil)
        navigationController?.pushViewController(tabBarVC, animated: true)
    }
}
