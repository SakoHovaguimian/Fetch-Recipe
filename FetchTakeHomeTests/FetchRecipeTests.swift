//
//  FetchRecipeTests.swift
//  FetchRecipeTests
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import Testing
@testable import FetchTakeHome

@Suite("Recipes")
struct FetchRecipeTests {
    
    private let apiService: APIServiceProtocol
    private let imageCacheService: ImageCacheServiceProtocol
    
    init() {
        
        self.apiService = APIService()
        self.imageCacheService = ImageCacheServiceMock()
        
    }

    @Test("Get Recipes")
    func getRecipes() async throws {
       
        let recipes = try await self.apiService.getRecipes()
        #expect(recipes.count > 0)
        
    }
    
    @Test("Get Malformed Recipes")
    func getMalformedRecipes() async throws {
       
        do {
            let recipes = try await self.apiService.getMalformedRecipes()
            #expect(recipes.isEmpty)
        }
        catch {
            #expect(error != nil)
        }
        
    }

}
