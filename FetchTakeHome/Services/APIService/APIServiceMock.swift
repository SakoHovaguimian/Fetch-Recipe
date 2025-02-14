//
//  APIServiceMock.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import UIKit

final class APIServiceMock: APIServiceProtocol {
        
    func getRecipes() async throws -> [Recipe] {
        return Recipe.DUMMY_DATA_ARRAY()
    }
    
    func getMalformedRecipes() async throws -> [Recipe] {
        throw APIService.APIError.decodingFailed
    }
    
    func getImage(url: URL) async throws -> UIImage? {
        return nil
    }
    
}
