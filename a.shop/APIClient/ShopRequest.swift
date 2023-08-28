//
//  ShopRequest.swift
//  a.shop
//
//  Created by Ильфат Салахов on 27.08.2023.
//

import Foundation

final class ShopRequest {
    private struct Constants {
        static let baseUrl = "https://www.avito.st/s/interns-ios"
    }
    
    private let endpoint: ShopEndpoint
    private let pathComponents: String
    private let stringDomen: String
    
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach { string += "/\($0)"}
        }
        
        if !stringDomen.isEmpty {
            string += "."
            string += ("\(stringDomen)")
        }
        
        return string
    }
    
    // MARK: - Public
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public let httpMethod = "GET"
    
    init(endpoint: ShopEndpoint, pathComponents: String = "", stringDomen: String = "json") {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.stringDomen = stringDomen
    }
}

extension ShopRequest {
    static let listProducts = ShopRequest(endpoint: .main)
}
