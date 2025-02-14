//
//  Recipe.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import UIKit

struct Recipe: Identifiable,
               Codable,
               Hashable,
               Mockable {
    
    let id: String
    let cuisine: String
    let name: String
    let photoURLLarge: String?
    let photoURLSmall: String?
    let sourceURL: String?
    let youtubeURL: String?
    
    var image: UIImage? = nil
    
    private enum CodingKeys: String, CodingKey {
        
        case id = "uuid"
        case cuisine = "cuisine"
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
        
    }
    
}

extension Recipe {
    
    static func DUMMY_DATA() -> Self {
        
        return .init(
            id: UUID().uuidString,
            cuisine: "Armenian",
            name: "Cheese Boureg",
            photoURLLarge: nil,
            photoURLSmall: nil,
            sourceURL: "www.google.com",
            youtubeURL: "www.youtube.com"
        )
        
    }
    
    static func DUMMY_DATA_ARRAY() -> [Self] {
        
        return [
            .DUMMY_DATA(),
            .DUMMY_DATA(),
            .DUMMY_DATA(),
            .DUMMY_DATA(),
        ]
        
    }
    
}
