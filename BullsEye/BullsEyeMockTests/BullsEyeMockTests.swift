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
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "gameStyle" {
            gameStyleChanged += 1
        }
    }
}

class BullsEyeMockTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
}
