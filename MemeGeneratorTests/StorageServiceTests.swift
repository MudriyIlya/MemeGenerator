//
//  StorageServiceTests.swift
//  MemeGeneratorTests
//
//  Created by Илья Мудрый on 20.09.2021.
//

import XCTest
@testable import MemeGenerator

class StorageServiceTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testStorageCount() {
        let countMemes = StorageService().count()
        XCTAssertNotNil(countMemes, "Не нил, должно быть равно 0 или больше")
    }
}
