//
//  ConstantsTests.swift
//  MemeGeneratorTests
//
//  Created by Илья Мудрый on 20.09.2021.
//

import XCTest
@testable import MemeGenerator

class ConstantsTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    // MARK: - Constants Test
    
    func testCollectionInset() {
        let collectionInset = Constants.collectionCellInset
        XCTAssertEqual(collectionInset, 3, "Неверное значение инсетов")
    }
    
    func testCornerRadius() {
        let cornerRadius = Constants.cornerRadius
        XCTAssertEqual(cornerRadius, 5, "Неверное значение скругления углов")
    }
    
    func testImpactFont() {
        guard let font = Constants.impactFont else { return }
        XCTAssertEqual(font.familyName, "Impact", "Не тот шрифт")
    }
}
