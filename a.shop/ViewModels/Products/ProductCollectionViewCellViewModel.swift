//
//  ProductCollectionViewCellViewModel.swift
//  a.shop
//
//  Created by Ильфат Салахов on 28.08.2023.
//

import Foundation

final class ProductCollectionViewCellViewModel: Hashable, Equatable {
    
    let productModel: ProductModel
    
    init(productModel: ProductModel) {
        self.productModel = productModel
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = productModel.imageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageManager.shared.dowloadImage(url, completion: completion)
    }
    
    // MARK: - Hashable
    
    static func == (lhs: ProductCollectionViewCellViewModel, rhs: ProductCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(productModel.title)
        hasher.combine(productModel.price)
        hasher.combine(productModel.location)
        hasher.combine(productModel.createdDate)
        hasher.combine(productModel.imageURL)
    }
}


