//
//  CoreDataService.swift
//  CoreDataTest
//
//  Created by Илья Мудрый on 17.09.2021.
//

import Foundation
import CoreData

final class CoreDataService: CoreDataServiceProtocol {
    
    private let stack = CoreDataStack.shared
    
    private var memesResponse: [DBMemesResponse]?
}

extension CoreDataService {
    
    func getMemesFromDatabase(completion: @escaping (DBMemesResponse) -> Void) {
        let context = stack.container.viewContext
        context.performAndWait {
            let request = NSFetchRequest<DBMeme>(entityName: "DBMeme")
            do {
                let result = try request.execute()
                let memes: [Meme] = try result.map { meme in
                    guard let id = meme.id,
                          let imageURL = meme.imageURL,
                          let category = meme.category
                    else { throw CoreDataServiceError.unknown }
                    return Meme(id: id, category: Category(category), imageURL: imageURL)
                }
                completion(.success(memes))
            } catch {
                completion(.failure(.getMemes))
            }
        }
    }
    
    func save(_ memes: [Meme]) {
        stack.container.performBackgroundTask { context in
            memes.forEach { meme in
                let dbMeme = DBMeme(context: context)
                dbMeme.id = meme.id
                dbMeme.category = meme.category.current
                dbMeme.imageURL = meme.imageURL
                do {
                    try context.save()
                } catch {
                    print("Ошибка сохранения мемасов: \(error)")
                }
            }
        }
    }
    
    func deleteAll() {
        let context = stack.container.viewContext
        context.performAndWait {
            let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "DBMeme")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            deleteRequest.resultType = .resultTypeObjectIDs
            do {
                try context.execute(deleteRequest)
            } catch {
                print("Ошибка удаления мемасов: \(error)")
            }
        }
    }
}
