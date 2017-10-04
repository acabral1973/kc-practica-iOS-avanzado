//
//  MapActivities.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 22/9/17.
//  Copyright © 2017 KC. All rights reserved.
//

import CoreData
import CoreLocation

func MapActivityCDIntoActivityAnnotation(activityCD: ActivityCD) -> ActivityAnnotation {
    let activityLocation = CLLocation(latitude: Double(activityCD.latitude), longitude: Double(activityCD.longitude))
    let activityAnnotation = ActivityAnnotation(title: activityCD.name!, subtitle: activityCD.address!, coordinate: activityLocation.coordinate, activity: mapActivityCDIntoActivity(activityCD: activityCD))
    
    return activityAnnotation
}

func MapActivityAnnotationIntoActivity(activityAnnotation: ActivityAnnotation) -> Activity {
    let activity : Activity = activityAnnotation.activity
    return activity
}

func mapActivityCDIntoActivity(activityCD: ActivityCD) -> Activity {
    let activity = Activity(name: activityCD.name ?? "Empty")
    activity.address = activityCD.address ?? ""
    activity.image = activityCD.image ?? ""
    activity.logo = activityCD.logo ?? ""
    
    activity.latitude = activityCD.latitude
    activity.longitude = activityCD.longitude
    
    activity.description = activityCD.description_en ?? ""
    activity.openingHours = activityCD.openingHours ?? ""
    
    return activity
}

func mapActivityIntoActivityCD(context: NSManagedObjectContext, activity: Activity) -> ActivityCD {
    let activityCD = ActivityCD(context: context)
    activityCD.name = activity.name
    activityCD.address = activity.address
    activityCD.image = activity.image
    activityCD.logo = activity.logo
    
    activityCD.latitude = activity.latitude!
    activityCD.longitude = activity.longitude!
    
    activityCD.description_en = activity.description
    activityCD.openingHours = activity.openingHours
    
    return activityCD
}


