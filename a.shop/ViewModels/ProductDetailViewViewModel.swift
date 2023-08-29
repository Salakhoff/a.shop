//
//  ProductDetailViewViewModel.swift
//  a.shop
//
//  Created by Ильфат Салахов on 28.08.2023.
//

import Foundation

final class ProductDetailViewViewModel {
    
    private let product: Advertisement
    
    enum SectionType: CaseIterable {
        case photo
        case info
    }
    
    public let sections = SectionType.allCases
    
    init(product: Advertisement) {
        self.product = product
    }
    
    private var requestUrl: URL? {
        let url = ShopRequest(endpoint: .details, pathComponents: [String(product.id)])
        return url.url
    }
    
    public func title() -> String {
        return product.title
    }
}
