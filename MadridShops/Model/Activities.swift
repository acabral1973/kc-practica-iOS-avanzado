//
//  Activities.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 21/9/17.
//  Copyright © 2017 KC. All rights reserved.
//

import Foundation

public protocol ActivitiesProtocol {
    func count() -> Int
    func add(activity: Activity)
    func get(index: Int) -> Activity
}

public final class Activities: ActivitiesProtocol {
    
    private var _activityList: [Activity]?
    
    public init() {
        self._activityList = []
    }
    
    public func count() -> Int {
        return (_activityList?.count)!
    }
    
    public func add(activity: Activity) {
        _activityList?.append(activity)
    }
    
    public func get(index: Int) -> Activity {
        return (_activityList?[index])!
    }
}
