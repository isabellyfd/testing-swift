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
        
        let dataTask = sessionUnderTest.dataTask(with: url!){
            data, response, error in
            
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            }else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                }else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCallToiTunesFails() {
        let url = URL(string: "https://itune.apple.com/search?media=music&entity=song&term=abba")
        
        let promise = expectation(description: "Completion handler invoker")
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
        
        XCTAssertNotNil(responseError)
    }
    
}
