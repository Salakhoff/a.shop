//
//  ViewController.swift
//  a.shop
//
//  Created by Ильфат Салахов on 27.08.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let productListView = ProductListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Товары"
        view.addSubview(productListView)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            productListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            productListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            productListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

