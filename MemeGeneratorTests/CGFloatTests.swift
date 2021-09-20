//
//  CGFloatTests.swift
//  MemeGeneratorTests
//
//  Created by Илья Мудрый on 20.09.2021.
//

import XCTest
@testable import MemeGenerator

class CGFloatTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testRandomNotNil() {
        let random = CGFloat.random()
        XCTAssertNotNil(random, "Вместо числа приходит nil")
    }
}
