//
//  CoreDataStack.swift
//  CoreDataTest
//
//  Created by Илья Мудрый on 17.09.2021.
//

import Foundation
import CoreData

final class CoreDataStack {

    static let shared = CoreDataStack()

    let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Memes")
        container.loadPersistentStores { desc, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        return container
    }()

    private init() {}
}
