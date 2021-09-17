//
//  MemesResponse.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 08.09.2021.
//

import Foundation

struct MemeDataResponse: Decodable {
    let id: UUID?
    let category: String
    let imageURL: String
}
