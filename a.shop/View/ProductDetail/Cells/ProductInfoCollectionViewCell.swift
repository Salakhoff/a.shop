//
//  ProductInfoCollectionViewCell.swift
//  a.shop
//
//  Created by Ильфат Салахов on 29.08.2023.
//

import UIKit

final class ProductInfoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Static Properties
    static let cellIdentifer = "ProductInfoCollectionViewCell"
    
    // MARK: - Outlets
    private var titleLabel = CustomLabel(size: 15, weight: .regular, color: .systemGray2)
    private var valueLabel = CustomLabel(size: 15, weight: .regular, color: .label)
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init and override methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueLabel.text = nil
        titleLabel.text = nil
    }
    
    // MARK: - Methods
    public func configure(with viewModel: ProductInfoCollectionViewCellViewModel) {
        
        titleLabel.text = viewModel.displayTitle
        valueLabel.text = viewModel.displayValue
        
        valueLabel.font = viewModel.setipFontValue
    }
    
}

private extension ProductInfoCollectionViewCell {
    func setupCell() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        contentView.addSubview(stackView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
}
