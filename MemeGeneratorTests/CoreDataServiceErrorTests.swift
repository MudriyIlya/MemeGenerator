//
//  CoreDataServiceErrorTests.swift
//  MemeGeneratorTests
//
//  Created by Илья Мудрый on 20.09.2021.
//

import XCTest
@testable import MemeGenerator

class CoreDataServiceErrorTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testGetMemesErrorMessage() {
        let getMemesError = CoreDataServiceError.getMemes
        XCTAssertEqual(getMemesError.message, "Невозможно получить мемасики", "Неправильное значение")
    }
    
    func testUnknownErrorMessage() {
        let unknownError = CoreDataServiceError.unknown
        XCTAssertEqual(unknownError.message, "Хз что происходит вообще", "Неправильное значение")
    }
}
