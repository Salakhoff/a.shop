//
//  ProductInfoCollectionViewCellViewModel.swift
//  a.shop
//
//  Created by Ильфат Салахов on 29.08.2023.
//

import UIKit

final class ProductInfoCollectionViewCellViewModel {
    
    public let value: String
    public let infoType: InfoType
    
    init(value: String, infoType: InfoType) {
        self.value = value
        self.infoType = infoType
    }
    
    enum InfoType {
        case title
        case price
        case location
        case createdDate
        case description
        case email
        case phoneNumber
        case address
        
        var displayTitle: String {
            switch self {
            case .title, .price:
                return ""
            case .location:
                return "Город:"
            case .createdDate:
                return "Дата создания объявления:"
            case .description:
                return "Описание:"
            case .email:
                return "Электронная почта для связи:"
            case .phoneNumber:
                return "Мобильный номер телефона для связи:"
            case .address:
                return "Адрес:"
            }
        }
        
        var setupFontValue: UIFont {
            switch self {
            case .title:
                return UIFont.systemFont(ofSize: 23, weight: .bold)
            case .price:
                return UIFont.systemFont(ofSize: 25, weight: .bold)
            case .location, .createdDate, .description, .email, .phoneNumber, .address:
                return UIFont.systemFont(ofSize: 15, weight: .medium)
            }
        }
    }
    
    public var displayTitle: String {
        self.infoType.displayTitle
    }
    
    public var setipFontValue: UIFont {
        self.infoType.setupFontValue
    }
    
    public var displayValue: String {
        if value.isEmpty {
            return "None"
        }
        
        if self.infoType == .createdDate,
           let formatDate = formatDateString(value) {
            return formatDate
        }
        return value
    }
}

extension ProductInfoCollectionViewCellViewModel {
    func formatDateString(_ dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMMM yyyy"
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
}

