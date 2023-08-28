//
//  Product.swift
//  a.shop
//
//  Created by Ильфат Салахов on 27.08.2023.
//

import Foundation

struct ProductModel {
    
    let title: String
    let price: String
    let location: String
    let imageURL: URL?
    let createdDate: String
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = imageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}

