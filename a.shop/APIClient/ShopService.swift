//
//  ShopService.swift
//  a.shop
//
//  Created by Ильфат Салахов on 27.08.2023.
//

import Foundation

final class ShopService {
    
    static let shared = ShopService()
    
    private init() {}
    
    public func execute<T: Codable>(
        expecting type: T.Type,
        _ request: ShopRequest,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ShopError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data, error == nil else {
                completion(.failure(error ?? ShopError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
                
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
    
    // MARK: - Private
    private func request(from shopRequest: ShopRequest) -> URLRequest? {
        guard let url = shopRequest.url else { return nil }
        var request = URLRequest(url: url)
        
        request.httpMethod = shopRequest.httpMethod
        
        return request
    }
}

