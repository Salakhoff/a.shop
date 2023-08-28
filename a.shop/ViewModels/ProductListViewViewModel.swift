//
//  ProductListViewViewModel.swift
//  a.shop
//
//  Created by Ильфат Салахов on 28.08.2023.
//

import UIKit

protocol ProductListViewViewModelDelegate: AnyObject {
    func didLoadInitialProducts()
}

final class ProductListViewViewModel: NSObject {
    
    public weak var delegate: ProductListViewViewModelDelegate?
    
    private var products: [Advertisement] = [] {
        didSet {
            for product in products {
                let productModel = ProductModel(title: product.title,
                                                price: product.price,
                                                location: product.location,
                                                imageURL: URL(string: product.imageURL),
                                                createdDate: product.createdDate
                )
                let viewModel = ProductCollectionViewCellViewModel(productModel: productModel)
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [ProductCollectionViewCellViewModel] = []
    
    public func fetchProducts() {
        ShopService.shared.execute(expecting: GetAllProductsResponse.self, .listProducts) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.advertisements
                self?.products = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialProducts()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ProductListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width =  (bounds.width - 30) / 2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
}


