//
//  ProductCollectionViewCell.swift
//  a.shop
//
//  Created by Ильфат Салахов on 28.08.2023.
//

import UIKit

final class ProductCollectionViewCell: UICollectionViewCell {
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let productTitleLabel = CustomLabel(size: 15, weight: .medium, color: .darkGray)
    private let productPriceLabel = CustomLabel(size: 15, weight: .semibold, color: .darkGray)
    private let productPlaceLabel = CustomLabel(size: 13, weight: .light, color: .systemGray)
    private let productDateSellLabel = CustomLabel(size: 13, weight: .light, color: .systemGray)
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    static let cellIdentifier = "ProductCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        productPlaceLabel.text = nil
        productPriceLabel.text = nil
        productTitleLabel.text = nil
        productDateSellLabel.text = nil
    }
    
    public func configure(with viewModel: ProductCollectionViewCellViewModel) {
        self.productPlaceLabel.text = viewModel.productModel.title
        self.productPriceLabel.text = viewModel.productModel.price
        self.productTitleLabel.text = viewModel.productModel.title
        self.productDateSellLabel.text = viewModel.productModel.createdDate
        
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.productImageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetupSubviews
private extension ProductCollectionViewCell {
    private func setupSubviews() {
        contentView.backgroundColor = .secondarySystemBackground
        
        stackView.addArrangedSubview(productTitleLabel)
        stackView.addArrangedSubview(productPriceLabel)
        stackView.addArrangedSubview(productPlaceLabel)
        stackView.addArrangedSubview(productDateSellLabel)
        
        contentView.addSubview(stackView)
        contentView.addSubview(productImageView)
       
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -3),
            
            productTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            productPriceLabel.heightAnchor.constraint(equalToConstant: 25),
            productPlaceLabel.heightAnchor.constraint(equalToConstant: 20),
            productDateSellLabel.heightAnchor.constraint(equalToConstant: 20),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

