//
//  DetailViewController.swift
//  a.shop
//
//  Created by Ильфат Салахов on 27.08.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let viewModel: ProductDetailViewViewModel
    
    init(viewModel: ProductDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title()
    }
}
