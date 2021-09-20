//
//  PreviewMemeTests.swift
//  MemeGeneratorTests
//
//  Created by Илья Мудрый on 20.09.2021.
//

import XCTest
@testable import MemeGenerator

class PreviewMemeTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    // MARK: - PreviewMeme Test
    
    func testPreviewInitializationWorking() {
        // arrange
        guard let image = UIImage(systemName: "photo") else { return }
        let name = "Зубенко Михаил Петрович"
        let previewMeme = PreviewMeme(withName: name, image: image)
        // act
        // assert
        XCTAssertNotNil(previewMeme, "\(name) не инициализировался")
    }
}
