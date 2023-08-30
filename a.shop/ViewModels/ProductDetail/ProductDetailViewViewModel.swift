//
//  ProductDetailViewViewModel.swift
//  a.shop
//
//  Created by Ильфат Салахов on 28.08.2023.
//

import UIKit

final class ProductDetailViewViewModel {
    
    private let product: Advertisement
    
    private var detailProduct =  DetailProductModel()
    
    enum SectionType {
        case photo(viewModel: ProductPhotoCollectionViewCellViewModel)
        case info(viewModel: [ProductInfoCollectionViewCellViewModel])
    }
    
    public var sections: [SectionType] = []
    
    init(product: Advertisement) {
        self.product = product
        setupSections()
    }
    
    public func setupSections() {
        sections = [
            .photo(viewModel: .init(imageUrl: URL(string: detailProduct.imageURL))),
            .info(viewModel: [
                .init(title: "", value: detailProduct.title),
                .init(title: "Цена", value: detailProduct.price),
                .init(title: "Город", value: detailProduct.location),
                .init(title: "Дата объявления", value: detailProduct.createdDate),
                .init(title: "Описание", value: detailProduct.description),
                .init(title: "Номер для связи", value: detailProduct.phoneNumber),
                .init(title: "Точный адрес", value: detailProduct.address),
                .init(title: "Почта для связи", value: detailProduct.email)
            ])
        ]
    }
    
    private var requestUrl: URL? {
        let url = ShopRequest(endpoint: .details, pathComponents: [String(product.id)])
        return url.url
    }
    
    public func fetchProductInfo() {
        guard let url = requestUrl,
              let request = ShopRequest(url: url) else {
            print("Failed to create")
            return
        }
        ShopService.shared.execute(expecting: GetProductResponse.self, request) { [weak self] result in
            switch result {
            case .success(let responseModel):
                guard let self else { return }
                self.detailProduct = DetailProductModel(
                    title: responseModel.title,
                    price: responseModel.price,
                    location: responseModel.location,
                    imageURL: responseModel.imageURL,
                    createdDate: responseModel.createdDate,
                    description: responseModel.description,
                    email: responseModel.email,
                    phoneNumber: responseModel.phoneNumber,
                    address: responseModel.address
                )
                setupSections()
            case .failure(let error):
                print(String(describing: error))
            }
        }
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
