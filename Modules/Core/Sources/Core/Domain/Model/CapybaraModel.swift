//
//  CapybaraModel.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import Foundation

public struct CapybaraModel: Equatable, Identifiable {
    
    public let id: String
    public let title: String
    public let image: String
    public let description: String
    public var isFavorite: Bool
    
    public init(
        id: String,
        title: String,
        image: String,
        description: String,
        isFavorite: Bool
    ) {
        self.id = id
        self.title = title
        self.image = image
        self.description = description
        self.isFavorite = isFavorite
    }
    
}
