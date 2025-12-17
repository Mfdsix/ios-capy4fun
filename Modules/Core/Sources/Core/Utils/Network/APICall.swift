//
//  APICall.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import Foundation

struct API {
    
    static let baseUrl = "https://api.capy.lol/v1"
    
}

protocol Endpoint {
    
    var url: String { get }
    
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case capybaras
        
        public var url: String {
            switch self {
            case .capybaras: return "\(API.baseUrl)/capybaras?random=true&take=10"
            }
        }
    }
    
}
