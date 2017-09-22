//
//  ActivitiesTests.swift
//  MadridShopsTests
//
//  Created by Alejandro Cabral Benavente on 21/9/17.
//  Copyright © 2017 KC. All rights reserved.
//

import XCTest
import MadridShops

class ActivitiesTests: XCTestCase {
    
    let testActivityOne = Activity(name: "test activity one")
    let testActivityTwo = Activity(name: "test activity two")
    
    func testActivityExistence(){
        XCTAssertNotNil(testActivityOne)
    }
    
    func testActivitiesComparisons(){
        
        // Identity
        XCTAssertEqual(testActivityOne, testActivityOne)
        
        // Equal
        let otherActivity = Activity(name: "test activity one")
        XCTAssertEqual(testActivityOne, otherActivity)
        
        // Not Equal
        XCTAssertNotEqual(testActivityOne, testActivityTwo)
        
        // Less than
        XCTAssertLessThan(testActivityOne, testActivityTwo)
    }
    
    func testActivityHashable() {
        XCTAssertNotNil(testActivityOne.hashValue)
    }
    
    // Activities Class Tests
    
    func testEmptyActivitiesHasZeroActivities() {
        let testActivities = Activities()
        XCTAssertEqual(0, testActivities.count())
    }
    
    func testAddActivityToActivities() {
        let testActivities = Activities()
        testActivities.add(activity: Activity(name: "Activity"))
        XCTAssertEqual(1, testActivities.count())
    }
}
