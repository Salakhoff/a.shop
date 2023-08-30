//
//  Product.swift
//  a.shop
//
//  Created by Ильфат Салахов on 27.08.2023.
//

import Foundation

struct ProductModel {
    
    let title: String
    let price: String
    let location: String
    let imageURL: URL?
    let createdDate: String
    
    var formattedDate: String {
        if let formatted = formatDate(createdDate) {
            return formatted
        }
        return createdDate
    }
    
    func formatDate(_ dateString: String) -> String? {
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


//extension ProductModel {
//    func formatDateString(_ dateString: String) -> String? {
//        let inputFormatter = DateFormatter()
//        inputFormatter.dateFormat = "yyyy-MM-dd"
//
//        if let date = inputFormatter.date(from: dateString) {
//            let outputFormatter = DateFormatter()
//            outputFormatter.dateFormat = "dd MMMM yyyy"
//
//            return outputFormatter.string(from: date)
//        }
//
//        return nil
//    }
//}

