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
    func loadMemeImage(imageURL: String, completion: @escaping (Data?) -> Void)
}
