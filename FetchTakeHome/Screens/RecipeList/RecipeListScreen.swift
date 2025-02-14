//
//  RecipeListScreen.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import SwiftUI

struct RecipeListScreen: View {
    
    @StateObject var viewModel: RecipeListViewModel
    
    init(viewModel: RecipeListViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
                
        NavigationStack {
            
            recipeListView()
                .overlay {
                    
                    if self.viewModel.isLoading {
                        LoadingView()
                    }
                    
                }
            
        }
        .onAppear {
            
            self.viewModel
                .loadData()
            
        }

    }
    
    private func recipeListView() -> some View {
        
        ScrollView {
            
            LazyVStack {
                
                if self.viewModel.isEmpty {
                    emptyView()
                }
                else {
                    
                    ForEach(self.viewModel.recipes) { recipe in
                        
                        recipeView(recipe)
                        
                    }
                    
                }
                
            }
            
        }
        .refreshable {
            
            self.viewModel
                .reloadData()
            
        }
        .animation(
            .bouncy,
            value: self.viewModel.recipes
        )
        .navigationTitle("Recipes")
        .background(Color(uiColor: .systemGray6))
        .alert("No Recipes Available 😢! Please try again later.", isPresented: .constant(self.viewModel.error != nil)) {
            
            AppButton(
                title: "Refresh",
                action: self.viewModel.reloadData
            )
            
        }
        
    }
    
    private func recipeView(_ recipe: Recipe) -> some View {
        
        RecipeView(recipe: recipe) { url in
            
            self.viewModel
                .selectRecipeURL(url)
            
        }
        .asButton {
            
            self.viewModel
                .selectRecipe(recipe)
            
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
        
        
    }
    
    private func emptyView() -> some View {
        
        ContentUnavailableView(
            "No Recipes Found",
            systemImage: "fork.knife.circle",
            description: Text("No recipes found. Please try again later.")
        )
        
    }

}

#Preview {
    
    let viewModel = RecipeListViewModel(
        apiService: APIServiceMock(),
        imageCacheService: ImageCacheServiceMock()
    )
    
    return RecipeListScreen(viewModel: viewModel)
    
}
