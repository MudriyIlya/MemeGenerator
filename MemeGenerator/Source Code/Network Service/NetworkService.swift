//
//  NetworkService.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 08.09.2021.
//

import Foundation

final class NetworkService {
    
    private let session = URLSession.shared
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private var memesResponse: [MemeDataResponse]?
}

extension NetworkService: NetworkServiceProtocol {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    func getMemes(completion: @escaping (MemesAPIResponse) -> Void) {
        // 1
        let components = URLComponents(string: MemesAPI.baseURL)
        guard let url = components?.url else { return completion(.failure(.unknown)) }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get
        
        // 2
        let handler: Handler = { [weak self] data, response, error in
            do {
                guard let self = self else { return completion(.failure(.unknown)) }
                let data = try self.httpResponse(data: data, response: response)
                self.memesResponse = try self.decoder.decode([MemeDataResponse].self, from: data)
                guard let memesResponse = self.memesResponse else { return completion(.failure(.unknown)) }
                completion(.success((memesResponse)))
            } catch {
                completion(.failure((error as? NetworkServiceError) ?? .unknown))
            }
        }
        
        // 3
        session.dataTask(with: request, completionHandler: handler).resume()
    }
    
    func loadMemeImage(imageURL: String, completion: @escaping (Data?) -> Void) {
        // 1
        guard let url = URL(string: imageURL) else { return completion(nil) }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        let handler: Handler = { data, response, error in
            do {
                let data = try self.httpResponse(data: data, response: response)
                completion(data)
            } catch {
                completion(nil)
            }
        }
        
        session.dataTask(with: request, completionHandler: handler).resume()
    }
    
    private func httpResponse(data: Data?, response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode),
              let data = data
        else { throw NetworkServiceError.network }
        return data
    }
}
