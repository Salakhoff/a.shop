//
//  ProductInfoCollectionViewCell.swift
//  a.shop
//
//  Created by Ильфат Салахов on 29.08.2023.
//

import UIKit

final class ProductInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifer = "ProductInfoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: ProductInfoCollectionViewCellViewModel) {
        
    }
}
