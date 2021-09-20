//
//  HTTPMethodsTests.swift
//  MemeGeneratorTests
//
//  Created by Илья Мудрый on 20.09.2021.
//

import XCTest
@testable import MemeGenerator

class HTTPMethodsTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testInitializationGET() {
        let httpGet = HTTPMethods.get
        XCTAssertEqual(httpGet, "GET", "httpGet - не инициалицировался")
    }
    
    func testInitializationPOST() {
        let httpPost = HTTPMethods.post
        XCTAssertEqual(httpPost, "POST", "httpPost - не инициалицировался")
    }
    
    func testInitializationPUT() {
        let httpPut = HTTPMethods.put
        XCTAssertEqual(httpPut, "PUT", "httpPut - не инициалицировался")
    }
    
    func testInitializationPATCH() {
        let httpPatch = HTTPMethods.patch
        XCTAssertEqual(httpPatch, "PATCH", "httpPatch - не инициалицировался")
    }
    
    func testInitializationDELETE() {
        let httpDelete = HTTPMethods.delete
        XCTAssertEqual(httpDelete, "DELETE", "httpDelete - не инициалицировался")
    }
    
    func testInitializationAllProperties() {
        let httpGet = HTTPMethods.get
        let httpPost = HTTPMethods.post
        let httpPut = HTTPMethods.put
        let httpPatch = HTTPMethods.patch
        let httpDelete = HTTPMethods.delete
        XCTAssertNotNil(httpGet)
        XCTAssertNotNil(httpPost)
        XCTAssertNotNil(httpPut)
        XCTAssertNotNil(httpPatch)
        XCTAssertNotNil(httpDelete)
    }
}
