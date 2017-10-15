//
//  ViewController.swift
//  MadridShops
//
//  Created by Diego Freniche Brito on 07/09/2017.
//  Copyright © 2017 KC. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit
import SDWebImage


class ShopsViewController: UIViewController {
    
    @IBOutlet weak var shopsCollectionView: UICollectionView!
    @IBOutlet weak var shopsMap: MKMapView!
    
    var context: NSManagedObjectContext!
    let locationManager = CLLocationManager()
    var _fetchedResultsController: NSFetchedResultsController<ShopCD>? = nil
    var fetchedResultsController: NSFetchedResultsController<ShopCD> {
        if (_fetchedResultsController != nil) {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<ShopCD> = ShopCD.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        // fetchRequest == SELECT * FROM EVENT ORDER BY TIMESTAMP DESC
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: "ShopsCacheFile")
        // aFetchedResultsController.delegate = self
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setShopsMap()
        self.addShopsAnnotations()
        self.shopsCollectionView.delegate = self
        self.shopsCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shop: Shop = mapShopCDIntoShop(shopCD: self.fetchedResultsController.object(at: indexPath))
        self.performSegue(withIdentifier: "ShowShopDetailSegue", sender: shop)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopDetailSegue" {
            let vc = segue.destination as! ShopDetailViewController
            vc.shop = sender as! Shop
        }
    }
}




