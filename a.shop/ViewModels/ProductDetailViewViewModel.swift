//
//  ProductDetailViewViewModel.swift
//  a.shop
//
//  Created by Ильфат Салахов on 28.08.2023.
//

import Foundation

final class ProductDetailViewViewModel {
    
    private let product: Advertisement
    
    init(product: Advertisement) {
        self.product = product
    }
    
    public func title() -> String {
        return product.title
    }
}
