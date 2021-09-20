//
//  NetworkServiceProtocol.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 08.09.2021.
//

import Foundation

typealias MemesAPIResponse = Result<[MemeDataResponse], NetworkServiceError>

protocol NetworkServiceProtocol {
    func getMemes(completion: @escaping (MemesAPIResponse) -> Void)
    func loadMemeImage(imageURL: String, thumb: Bool, completion: @escaping (Data?) -> Void)
}

protocol NetworkServiceTest {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: NetworkServiceTest {
}
