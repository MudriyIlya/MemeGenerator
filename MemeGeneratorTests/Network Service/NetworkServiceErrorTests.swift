//
//  NetworkServiceErrorTests.swift
//  MemeGeneratorTests
//
//  Created by Илья Мудрый on 20.09.2021.
//

import XCTest
@testable import MemeGenerator

class NetworkServiceErrorTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testNetworkErrorMessage() {
        let networkError = NetworkServiceError.network
        XCTAssertEqual(networkError.message, "Ошибка сети", "Неправильное значение")
    }
    
    func testDecodableErrorMessage() {
        let decodableError = NetworkServiceError.decodable
        XCTAssertEqual(decodableError.message, "Ошибка парсинга", "Неправильное значение")
    }
    
    func testUnknownErrorMessage() {
        let unknownError = NetworkServiceError.unknown
        XCTAssertEqual(unknownError.message, "Неизвестная ошибка", "Неправильное значение")
    }
}
