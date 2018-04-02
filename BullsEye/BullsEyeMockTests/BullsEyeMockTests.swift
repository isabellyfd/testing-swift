//
//  BullsEyeMockTests.swift
//  BullsEyeMockTests
//
//  Created by Isabelly Damascena on 02/04/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import XCTest
@testable import BullsEye

class MockUserDefaults: UserDefaults {
    var gameStyleChanged = 0
    
    override func set(_ value: Int, forKey key: String) {
        if key == "gameStyle" {
            gameStyleChanged += 1
        }
    }
}


class BullsEyeMockTests: XCTestCase {
    
    var controllerUnderTest : ViewController!
    var mockUserDefaults : MockUserDefaults!
    
    override func setUp() {
        super.setUp()
        
        controllerUnderTest = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
        
        mockUserDefaults = MockUserDefaults(suiteName: "testing")
        controllerUnderTest.defaults = mockUserDefaults
    }
    
    override func tearDown() {
        mockUserDefaults = nil
        controllerUnderTest = nil
        super.tearDown()
    }
    
    func testGameStyleCanBeChanged() {
        let segmentedControl = UISegmentedControl()
        
        XCTAssertEqual(mockUserDefaults.gameStyleChanged, 0, "gameStyleChanged should be 0 before sendActions")
        segmentedControl.addTarget(controllerUnderTest, action: #selector(ViewController.chooseGameStyle(_:)), for: .valueChanged)
        segmentedControl.sendActions(for: .valueChanged)
        
        XCTAssertEqual(mockUserDefaults.gameStyleChanged, 1, "gameStyle default wasn't changed")
    }
    
    
}
