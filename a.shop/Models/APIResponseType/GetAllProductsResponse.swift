//
//  GetAllProductsResponse.swift
//  a.shop
//
//  Created by Ильфат Салахов on 28.08.2023.
//

import Foundation

struct GetAllProductsResponse: Codable {
    let advertisements: [Advertisement]
}

struct Advertisement: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageURL: String
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case location
        case imageURL = "image_url"
        case createdDate = "created_date"
    }
}
