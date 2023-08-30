//
//  ProductPhotoCollectionViewCellViewModel.swift
//  a.shop
//
//  Created by Ильфат Салахов on 29.08.2023.
//

import Foundation

final class ProductPhotoCollectionViewCellViewModel {
    
    public let imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ShopImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
    
}
