//
//  FetchTakeHomeApp.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import SwiftUI

@main
struct FetchTakeHomeApp: App {
    
    var body: some Scene {
        
        let viewModel = RecipeListViewModel(
            apiService: APIService(),
            imageCacheService: ImageCacheService()
        )
        
        WindowGroup {
            RecipeListScreen(viewModel: viewModel)
        }
        
    }
    
}
