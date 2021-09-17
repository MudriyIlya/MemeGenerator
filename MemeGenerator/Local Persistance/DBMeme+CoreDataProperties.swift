//
//  DBMeme+CoreDataProperties.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 17.09.2021.
//
//

import Foundation
import CoreData

extension DBMeme {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBMeme> {
        return NSFetchRequest<DBMeme>(entityName: "DBMeme")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var category: String?
    @NSManaged public var imageURL: String?

}

extension DBMeme: Identifiable {

}
