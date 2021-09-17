//
//  CoreDataServiceProtocol.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 17.09.2021.
//

import Foundation

typealias DBMemesResponse = Result<[Meme], CoreDataServiceError>

protocol CoreDataServiceProtocol {
    func getMemesFromDatabase(completion: @escaping (DBMemesResponse) -> Void)
    func save(_ memes: [Meme])
    func deleteAll()
}
