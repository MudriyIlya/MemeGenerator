//
//  CoreDataServiceError.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 17.09.2021.
//

import Foundation

enum CoreDataServiceError: Error {
    case getMemes
    case unknown
    
    var message: String {
        switch self {
        case .getMemes: return "Невозможно получить мемасики"
        case .unknown:  return "Хз что происходит вообще"
        }
    }
}
