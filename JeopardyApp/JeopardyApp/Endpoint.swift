//
//  Endpoint.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 4.10.2021.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "jservice.io"
        components.path = "/api" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    static var randomClue: Self {
        return Endpoint(path: "/random")
    }
    
    static var sixRandomClues: Self {
        return Endpoint(path:"/random", queryItems: [URLQueryItem(name: "count", value: "6")])
    }
    static func category(_ id: String) -> Self {
        return Endpoint(path: "/category", queryItems: [URLQueryItem(name: "id", value: id)])
    }
    
    static func cluesForCategory(_ id: String) -> Self {
        return Endpoint(path: "/clues", queryItems: [URLQueryItem(name: "category", value: id)])
    }
}
