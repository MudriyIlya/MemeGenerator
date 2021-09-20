//
//  MemeGeneratorUITests.swift
//  MemeGeneratorUITests
//
//  Created by Илья Мудрый on 03.09.2021.
//

import XCTest

class MemeGeneratorUITests: XCTestCase {
    
    var app: XCUIApplication!
        
    func testSettingsScreenImage() throws {
        app = XCUIApplication()
        app.launch()
        LibraryScreen(app: app)
            .tapSettingsButton()
            .tapInstagramImageView()
    }
}
