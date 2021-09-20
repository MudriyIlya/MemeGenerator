//
//  SnapshotTests.swift
//  MemeGeneratorUITests
//
//  Created by Илья Мудрый on 20.09.2021.
//

import XCTest
import SnapshotTesting

@testable import MemeGenerator

class SnapshotTests: XCTestCase {
    
    func testScreenSnapshot() {
        let viewController = LibraryViewController()
        assertSnapshot(matching: viewController, as: .image)
    }
}
