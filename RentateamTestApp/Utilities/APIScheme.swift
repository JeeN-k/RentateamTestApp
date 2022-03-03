//
//  APIScheme.swift
//  RentateamTestApp
//
//  Created by Oleg Stepanov on 02.03.2022.
//

import Foundation

enum APIS {
    case galleryList
    
    func getAPI() -> APIScheme {
        switch self {
        case .galleryList:
            return APIScheme(path: "/photos")
        }
    }
}

struct APIScheme {
    var scheme: String
    var host: String
    var path: String
    
    init (path: String) {
        self.scheme = "https"
        self.host = "api.unsplash.com"
        self.path = path
    }
}
