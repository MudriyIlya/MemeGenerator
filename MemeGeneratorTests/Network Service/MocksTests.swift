//
//  File.swift
//  MemeGeneratorTests
//
//  Created by Илья Мудрый on 20.09.2021.
//

import XCTest

// class URLSessionDataTaskMock: URLSessionDataTask {
//    private let closure: () -> Void
//
//    init(closure: @escaping () -> Void) {
//        self.closure = closure
//    }
    
//    override func resume() {
//        closure()
//    }
// }

class URLSessionMock: NetworkServiceTest {
    
    // swiftlint:disable large_tuple
    var result: (Data?, URLResponse?, Error?)?
    
    var completion: CompletionHandler?
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    var request: URLRequest?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        self.request = request
        self.completion = completionHandler
        return URLSession.shared.dataTask(with: URL(string: "https://google.com/")!) { _, _, _ in }
    }
    
    func finishDownload() {
        if let result = result {
            completion?(result.0, result.1, result.2)
            completion = nil
        }
    }
}
