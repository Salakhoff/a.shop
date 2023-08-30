//
//  ProductDetailViewViewModel.swift
//  a.shop
//
//  Created by Ильфат Салахов on 28.08.2023.
//

import UIKit

final class ProductDetailViewViewModel {
    
    // MARK: - SectionTypeEnum
    enum SectionType {
        case photo(viewModel: ProductPhotoCollectionViewCellViewModel)
        case info(viewModel: [ProductInfoCollectionViewCellViewModel])
    }
    
    // MARK: - Properties
    private let product: Advertisement
    
    private var detailProduct =  DetailProductModel()
    
    public var sections: [SectionType] = []
    
    // MARK: Init
    init(product: Advertisement) {
        self.product = product
    }
    
    // MARK: - Methods
    func setupSections() {
        sections = [
            .photo(viewModel: .init(imageUrl: URL(string: detailProduct.imageURL))),
            .info(viewModel: [
                .init(value: detailProduct.price, infoType: .price),
                .init(value: detailProduct.title, infoType: .title),
                .init(value: detailProduct.createdDate, infoType: .createdDate),
                .init(value: detailProduct.description, infoType: .description),
                .init(value: detailProduct.location, infoType: .location),
                .init(value: detailProduct.address, infoType: .address),
                .init(value: detailProduct.phoneNumber, infoType: .phoneNumber),
                .init(value: detailProduct.email, infoType: .email),
            ])
        ]
    }
    
    // MARK: - FetchProductInfo
    private var requestUrl: URL? {
        let url = ShopRequest(endpoint: .details, pathComponents: [String(product.id)])
        return url.url
    }
    
    func fetchProductInfo() {
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
    
    // MARK: - Layouts
    func createPhotoSectionLayout() -> NSCollectionLayoutSection {
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
    
    func createInfoSectionLayout() -> NSCollectionLayoutSection {
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
                heightDimension: .fractionalHeight(0.09)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
