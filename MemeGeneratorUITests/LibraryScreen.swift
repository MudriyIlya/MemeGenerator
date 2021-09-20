//
//  LibraryScreen.swift
//  MemeGeneratorUITests
//
//  Created by Илья Мудрый on 20.09.2021.
//

import XCTest

class LibraryScreen: Page {
    
    var app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    private enum Identifiers {
        static let settingsButton = "settingsButton"
        static let navBar = "navigationBar"
    }
    
    func tapSettingsButton() -> SettingsScreen {
        let bar = app.navigationBars.element(matching: .navigationBar, identifier: Identifiers.navBar)
        let button = bar.buttons.element(matching: .button, identifier: Identifiers.settingsButton)
        XCTAssertTrue(button.waitForExistence(timeout: 10))
        button.tap()
        return SettingsScreen(app: app)
    }
}
