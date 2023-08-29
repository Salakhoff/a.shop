//
//  ProductDetailViewViewModel.swift
//  a.shop
//
//  Created by Ильфат Салахов on 28.08.2023.
//

import UIKit

final class ProductDetailViewViewModel {
    
    private let product: Advertisement
    
    enum SectionType {
        case photo(viewModel: ProductPhotoCollectionViewCellViewModel)
        case info(viewModel: [ProductInfoCollectionViewCellViewModel])
    }
    
    public var sections: [SectionType] = []
    
    init(product: Advertisement) {
        self.product = product
        setupSections()
    }
    
    private func setupSections() {
        sections = [
            .photo(viewModel: .init()),
            .info(viewModel: [
                .init(),
                .init(),
                .init()
            ])
        ]
    }
    
    private var requestUrl: URL? {
        let url = ShopRequest(endpoint: .details, pathComponents: [String(product.id)])
        return url.url
    }
    
    public func title() -> String {
        return product.title
    }
    
    // MARK: - Layouts
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 0,
                                                        bottom: 10,
                                                        trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 2,
                                                        leading: 2,
                                                        bottom: 2,
                                                        trailing: 2)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(40)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
