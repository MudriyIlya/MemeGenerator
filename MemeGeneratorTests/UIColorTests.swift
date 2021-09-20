//
//  UIColorTests.swift
//  MemeGeneratorTests
//
//  Created by Илья Мудрый on 20.09.2021.
//

import XCTest
@testable import MemeGenerator

class UIColorTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testRandomColorNotNil() {
        let randomColor = UIColor.random()
        XCTAssertNotNil(randomColor, "Цвета нет, приходит nil")
    }
}
