//
//  CustomLabel.swift
//  a.shop
//
//  Created by Ильфат Салахов on 28.08.2023.
//

import UIKit

final class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(size: CGFloat, weight: UIFont.Weight, color: UIColor = .black) {
        self.init()
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.textColor = color
        self.numberOfLines = 2
        self.minimumScaleFactor = 0.9
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
