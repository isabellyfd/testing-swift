//
//  HalfTunesTests.swift
//  HalfTunesTests
//
//  Created by Isabelly Damascena on 02/04/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import XCTest
@testable import HalfTunes
class HalfTunesTests: XCTestCase {
    
    var sessionUnderTest : URLSession!
    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }
    
    func testValidCallToiTunesGetsHTTPStatus200() {
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
        
        let promise = expectation(description: "Status code: 200")
        var statusCode : Int?
        var responseError : Error?
        
        let dataTask = sessionUnderTest.dataTask(with: url!){
            data, response, error in
            statusCode =  (response as? HTTPURLResponse)?.statusCode
            responseError = error
            
            promise.fulfill()
        }
        
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testCallToiTunesFails() {
        let url = URL(string: "https://itune.apple.com/search?media=music&entity=song&term=abba")
        
        let promise = expectation(description: "Completion handler invoker")
        var responseError : Error?
        
        let dataTask = sessionUnderTest.dataTask(with: url!){
            data, response, error in
            responseError = error
            
            promise.fulfill()
           
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(responseError)
    }
    
}
