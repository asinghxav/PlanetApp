//
//  PlanetAppTests.swift
//  PlanetAppTests
//
//  Created by Abhishek Singh on 07/01/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import XCTest
@testable import PlanetApp

class PlanetAppTests: XCTestCase {


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }

    func testUrl() {
        XCTAssertEqual(PlanetAPIUrls.baseUrl.rawValue, "https://swapi.co")
        XCTAssertEqual(PlanetAPIUrls.getPlanetList.rawValue, "/api/planets/")
    }
    
    func testNetworkLocalizedError() {
        XCTAssertEqual(URLRequestError.networkUnavailable.errorDescription, "Unable to complete network request. No Internet connection present.")
        XCTAssertEqual(URLRequestError.sessionExpired.errorDescription, "Your session has expired.")
        XCTAssertEqual(URLRequestError.otherError.errorDescription, "Server error. Please contact us.")
        XCTAssertEqual(URLRequestError.noData.errorDescription, "Did not receive data.")
    }
    
    func testDBEntity() {
        XCTAssertEqual(DBmanger.CoreDataEntityName.planetInfo , DBmanger.CoreDataEntityName(rawValue: "PlanetInfo"))
    }
    
}
