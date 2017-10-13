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

class ActivitiesViewController: UIViewController {
    
    @IBOutlet weak var activitiesMap: MKMapView!
    @IBOutlet weak var activitiesCollectionView: UICollectionView!
    
    var context: NSManagedObjectContext!
    let locationManager = CLLocationManager()
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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setActivitiesMap()
        self.addActivitiesAnnotations()
        self.activitiesCollectionView.delegate = self
        self.activitiesCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activity: Activity = mapActivityCDIntoActivity(activityCD: self.fetchedResultsController.object(at: indexPath))
        self.performSegue(withIdentifier: "ShowActivityDetailSegue", sender: activity)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowActivityDetailSegue" {
            let vc = segue.destination as! ActivityDetailViewController
            vc.activity = sender as! Activity
        }
    }
}

