//
//  SettingsScreen.swift
//  MemeGeneratorUITests
//
//  Created by Илья Мудрый on 20.09.2021.
//

import XCTest

class SettingsScreen: Page {
    
    var app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    private enum Identifiers {
        static let instagramImage = "InstagramImage"
        static let instagramLabel = "InstagramLabel"
    }

    func tapInstagramImageView() {
        let image = app.images[Identifiers.instagramImage]
        XCTAssertTrue(image.waitForExistence(timeout: 10))
        image.tap()
    }
}
