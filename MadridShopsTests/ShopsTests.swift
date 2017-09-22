//
//  ShopsTests.swift
//  MadridShopsTests
//
//  Created by Diego Freniche Brito on 07/09/2017.
//  Copyright © 2017 KC. All rights reserved.
//

import XCTest
import MadridShops

class ShopsTests: XCTestCase {
    
    func testGivenEmptyShopsNumberShopsIsZero() {
        let sut = Shops()
        XCTAssertEqual(0, sut.count())
    }
    
    func testGivenShopsWithOneElementNumberShopsIsOne() {
        let sut = Shops()
        sut.add(shop: Shop(name: "Shop"))
        XCTAssertEqual(1, sut.count())
    }
}
