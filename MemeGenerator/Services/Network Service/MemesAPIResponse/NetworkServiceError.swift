//
//  NetworkServiceError.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 08.09.2021.
//

enum NetworkServiceError: Error {
    case network
    case decodable
    case unknown
    
    var message: String {
        switch self {
        case .network:   return "Ошибка сети"
        case .decodable: return "Ошибка парсинга"
        case .unknown:   return "Неизвестная ошибка"
        }
    }
}
