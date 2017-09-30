 //
//  ActivitiesViewController.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 25/9/17.
//  Copyright © 2017 KC. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit

class ActivitiesViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var activitiesMap: MKMapView!
    @IBOutlet weak var activitiesCollectionView: UICollectionView!
    
    
    var context: NSManagedObjectContext!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        // La descarga de actividades solo se efectúa si no había sido ejecutada correctamente antes
        ExecuteOnceInteractorImpl().execute(key: "Activities") {
            initializeActivities()
        }
        
        self.activitiesCollectionView.delegate = self
        self.activitiesCollectionView.dataSource = self
        
        let madridLocation = CLLocation(latitude:40.41889 , longitude: -3.69194)
        self.activitiesMap.setCenter(madridLocation.coordinate, animated: true)
    }
    
    func initializeActivities() {
        
        // Descargo la info de todas las Actividades
        let downloadActivitiesInteractor: DownloadAllActivitiesInteractor = DownloadAllActivitiesInteractorNSURLSessionImpl()
        downloadActivitiesInteractor.execute { (activities: Activities) in
            print("👍 Total actividades descargadas: \(activities.count())")
            let cacheInteractor = SaveAllActivitiesInteractorImpl()
            cacheInteractor.execute(activities: activities, context: self.context, onSuccess: { (activities: Activities) in
                SetExecutedOnceInteractorImpl().execute(key : "Activities")
                
                self._fetchedResultsController = nil
                self.activitiesCollectionView.delegate = self
                self.activitiesCollectionView.dataSource = self
                self.activitiesCollectionView.reloadData()
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let activity: ActivityCD = self.fetchedResultsController.object(at: indexPath)
        self.performSegue(withIdentifier: "ShowActivityDetailSegue", sender: activity)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Identifico el segue que se ha activado
        if segue.identifier == "ShowActivityDetailSegue" {
            
            // Obtengo el destino del segue
            let vc = segue.destination as! ActivityDetailViewController
                       
            let activityCD: ActivityCD = sender as! ActivityCD
            vc.activity = mapActivityCDIntoActivity(activityCD: activityCD)
        }
    }
    
    
    // MARK: - Fetched results controller
    var _fetchedResultsController: NSFetchedResultsController<ActivityCD>? = nil
    
    var fetchedResultsController: NSFetchedResultsController<ActivityCD> {
        if (_fetchedResultsController != nil) {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<ActivityCD> = ActivityCD.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        // fetchRequest == SELECT * FROM EVENT ORDER BY TIMESTAMP DESC
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: "ActivitiesCacheFile")
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
        self.activitiesMap.setCenter(location.coordinate, animated: true)
    }
    
    
}

