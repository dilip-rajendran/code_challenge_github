//
//  code_challengeTests.swift
//  code_challengeTests
//
//  Created by Dilip on 4/5/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import XCTest
@testable import code_challenge

class code_challengeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testUserSearchDecodable() {
        let expectation = self.expectation(description: "API_Call_validation")
        NetworkLayer().getResponseForUrl(urlString: ConstantIdentifiers.BaseUserSearchURL.rawValue + "Dilip", UserSearchModel.self) { (data, error) in
            expectation.fulfill()
            if data != nil {
                XCTAssert(true, "User Search Decode - Passed")
            } else {
                XCTAssert(false, "User Search Decode - Failed")
            }
        }
        
        waitForExpectations(timeout: 15, handler: nil)
    }
    func testUserDetailsDecodable() {
        let expectation = self.expectation(description: "API_Call_validation")
        NetworkLayer().getResponseForUrl(urlString: "https://api.github.com/users/diliprajendran", User.self)
        { (data, error) in
            expectation.fulfill()
            if error != nil {
                XCTAssert(false, "Failed to decode")

            }
            if data != nil {
                XCTAssert(true, "Passed decode")
            }
        }
        
        waitForExpectations(timeout: 15, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
