//
//  ProductInfoCollectionViewCell.swift
//  a.shop
//
//  Created by Ильфат Салахов on 29.08.2023.
//

import UIKit

final class ProductInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifer = "ProductInfoCollectionViewCell"
    
    private var titleLabel = CustomLabel(size: 15, weight: .medium, color: .systemGray2)
    private var valueLabel = CustomLabel(size: 15, weight: .medium)
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        contentView.addSubview(stackView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueLabel.text = nil
        titleLabel.text = nil
    }
    
    public func configure(with viewModel: ProductInfoCollectionViewCellViewModel) {
        
        titleLabel.text = viewModel.displayTitle
        valueLabel.text = viewModel.displayValue
        
        valueLabel.font = viewModel.setipFontValue
    }
    
}
