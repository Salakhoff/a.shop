//
//  ProductCollectionViewCellViewModel.swift
//  a.shop
//
//  Created by Ильфат Салахов on 28.08.2023.
//

import Foundation

final class ProductCollectionViewCellViewModel {
    
    let productModel: ProductModel
    
    init(productModel: ProductModel) {
        self.productModel = productModel
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = productModel.imageURL else {
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
