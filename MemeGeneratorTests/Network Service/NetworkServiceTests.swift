//
//  NetworkServiceTests.swift
//  MemeGeneratorTests
//
//  Created by Илья Мудрый on 20.09.2021.
//

import XCTest
@testable import MemeGenerator

class NetworkServiceTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testSuccessfulResponse() {
        // Arrange
        let sessionMock = URLSessionMock()
        let service = NetworkService(session: sessionMock)
        
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "json", ofType: "txt")!
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return }
        let urlResponse = HTTPURLResponse(url: URL(fileURLWithPath: "https://google.com/"), statusCode: 200, httpVersion: nil, headerFields: nil)
        sessionMock.result = (data, urlResponse, nil)
        let expectation = XCTestExpectation(description: "memesData")
        var allMemes: [MemeDataResponse]?
        
        // Act
        service.getMemes { memesData in
            switch memesData {
            case .success(let memes):
                allMemes = memes
                print(memes)
            case .failure(let error):
                print(error)
            }
            expectation.fulfill()
        }
        sessionMock.finishDownload()
        // Assert
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(allMemes, "pipec")
    }
}
