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

class ShopsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var shopsCollectionView: UICollectionView!
    @IBOutlet weak var shopsMap: MKMapView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    
    var context: NSManagedObjectContext!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Inicializo servicios de localización
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.shopsMap.delegate = self
        self.locationManager.startUpdatingLocation()
        self.setShopsMap()
        
        // La descarga de tiendas solo se efectúa si no había sido ejecutada correctamente antes
        ExecuteOnceInteractorImpl().execute(key: "Shops") {
            initializeData()
        }
        self.shopsCollectionView.delegate = self
        self.shopsCollectionView.dataSource = self
        
    }
        
    func initializeData() {
        
        activityView.startAnimating()
        activityView.isHidden = false
        
        // Descargo la info de todas las tiendas
        let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsInteractorNSURLSessionImpl()
        downloadShopsInteractor.execute { (shops: Shops) in
            print("👍 Total tiendas descargadas: \(shops.count())")
            let cacheInteractor = SaveAllShopsInteractorImpl()
            cacheInteractor.execute(shops: shops, context: self.context, onSuccess: { (shops: Shops) in
                SetExecutedOnceInteractorImpl().execute(key : "Shops")
                
                self.activityView.stopAnimating()
                self.activityView.isHidden = true
                
                self._fetchedResultsController = nil
                self.shopsCollectionView.delegate = self
                self.shopsCollectionView.dataSource = self
                self.shopsCollectionView.reloadData()
            })
        } 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let shop: ShopCD = self.fetchedResultsController.object(at: indexPath)
        self.performSegue(withIdentifier: "ShowShopDetailSegue", sender: shop)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopDetailSegue" {
            let vc = segue.destination as! ShopDetailViewController

            let shopCD: ShopCD = sender as! ShopCD
            vc.shop = mapShopCDIntoShop(shopCD: shopCD)
        }
    }

    // MARK: - Fetched results controller
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
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        self.shopsMap.setCenter(location.coordinate, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        // Better to make this class property
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            // annotationView.image = UIImage(named: "marker")
        }
        
        return annotationView
    }
    

}

