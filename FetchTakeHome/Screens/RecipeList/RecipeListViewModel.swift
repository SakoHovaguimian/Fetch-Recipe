//
//  RecipeListViewModel.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import SwiftUI

final class RecipeListViewModel: ObservableObject {
    
    @Published private(set) var recipes: [Recipe] = []
    @Published private(set) var isLoading: Bool = false
    
    @Published var error: Error?
    
    var isEmpty: Bool {
        self.recipes.isEmpty && !self.isLoading
    }
    
    private let apiService: APIServiceProtocol!
    private let imageCacheService: ImageCacheServiceProtocol!
    
    init(apiService: APIServiceProtocol,
         imageCacheService: ImageCacheServiceProtocol) {
        
        self.apiService = apiService
        self.imageCacheService = imageCacheService
        
    }
    
    // MARK: - Public -
    
    func loadData() {
        
        guard !self.isLoading else { return }
        
        self.isLoading = true
        
        Task { [weak self] in
            
            do {
                
                let recipes = try await self?.fetchRecipes()
                try! await Task.sleep(for: .seconds(3))
                
                await MainActor.run { [weak self] in
                    
                    self?.recipes = recipes ?? []
                    self?.isLoading = false
                                        
                }
                
            }
            catch {
                
                await MainActor.run { [weak self] in
                    
                    self?.recipes = []
                    self?.error = error
                    
                }
                
            }
            
        }
        
    }
    
    func reloadData() {
        loadData()
    }
    
    func selectRecipe(_ recipe: Recipe) {
        print("Did select recipe: \(recipe.id)")
    }
    
    func selectRecipeURL(_ urlString: String?) {
        
        guard let urlString,
              let url = URL(string: urlString) else { return }
        
        openURL(url)
        
    }
    
    private func openURL(_ url: URL) {
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
        
    }
    
    // MARK: - Private -
    
    private func fetchRecipes() async throws -> [Recipe] {
        
        var recipes = try await self.apiService.getRecipes()
        
        for recipe in recipes {
            
            let image = try await self.fetchImageForRecipe(recipe)
            
            if let recipeIndex = recipes.firstIndex(of: recipe) {
                recipes[recipeIndex].image = image
            }
            
        }
        
        return recipes
        
    }
    
    private func fetchImageForRecipe(_ recipe: Recipe) async throws -> UIImage? {
        
        var url: String?
        
        if let largeImageURL = recipe.photoURLLarge {
            url = largeImageURL
        }
        
        if let smallImageURL = recipe.photoURLSmall {
            url = smallImageURL
        }
        
        if let url,
           let validURL = URL(string: url) {
            
            if let image = self.imageCacheService.image(for: recipe.id) {
                
                print("FETCHED FROM CACHE: \(recipe.name)")
                return image
                
            }
            
            let image = try await apiService.getImage(url: validURL)
            self.imageCacheService.insertImage(image, for: recipe.id)
            
            print("SAVED TO CACHE: \(recipe.name)")
            
            return image
            
        }
        
        return nil
        
    }
    
}
