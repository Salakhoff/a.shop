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
    private let pathComponents: [String]
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
    
    init(endpoint: ShopEndpoint, pathComponents: [String] = [], stringDomen: String = "json") {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.stringDomen = stringDomen
    }
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0] // Endpoint
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let shopEndpoint = ShopEndpoint(
                    rawValue: endpointString
                ) {
                    self.init(endpoint: shopEndpoint, pathComponents: pathComponents, stringDomen: "")
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                // value=name&value=name
                let _: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")

                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1]
                    )
                })

                if let shopEndpoint = ShopEndpoint(rawValue: endpointString) {
                    self.init(endpoint: shopEndpoint)
                    return
                }
            }
        }

        return nil
    }
}

extension ShopRequest {
    static let listProducts = ShopRequest(endpoint: .main)
}
