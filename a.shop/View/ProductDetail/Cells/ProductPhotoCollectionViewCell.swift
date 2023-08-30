//
//  ProductPhotoCollectionViewCell.swift
//  a.shop
//
//  Created by Ильфат Салахов on 29.08.2023.
//

import UIKit
import SDWebImage

final class ProductPhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Static Properties
    static let cellIdentifer = "ProductPhotoCollectionViewCell"
    
    // MARK: - Outlets
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init and Override methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
    }
    
    // MARK: - Methods
    func configure(with viewModel: ProductPhotoCollectionViewCellViewModel) {
        productImageView.sd_setImage(with: viewModel.imageUrl)
    }
}

// MARK: - SetupCell
private extension ProductPhotoCollectionViewCell {
    func setupCell() {
        contentView.addSubview(productImageView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
