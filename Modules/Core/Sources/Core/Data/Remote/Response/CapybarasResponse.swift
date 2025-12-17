//
//  CapybaraResponse.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import Foundation

nonisolated struct CapybarasResponse: Decodable, Sendable {
    
    let success: Bool
    let data: [CapybaraResponse]
    
}

nonisolated struct CapybaraResponse: Decodable, Sendable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "index"
        case image = "url"
        case description = "alt"
    }
    
    let id: Int32
    let image: String?
    let description: String?
    
}
