//
//  MapActivities.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 22/9/17.
//  Copyright © 2017 KC. All rights reserved.
//

import CoreData

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


