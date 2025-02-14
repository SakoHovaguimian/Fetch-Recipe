//
//  APIServiceProtocol.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import UIKit

protocol APIServiceProtocol {
        
    // Recipes
    
    func getRecipes() async throws -> [Recipe]
    func getMalformedRecipes() async throws -> [Recipe]
    
    // Images
    
    func getImage(url: URL) async throws -> UIImage?
    
}
