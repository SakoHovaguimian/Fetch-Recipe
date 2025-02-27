//
//  RecipeView.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import SwiftUI

struct RecipeView: View {
    
    private let recipe: Recipe
    private let urlAction: ((String) -> ())
    
    var photoURL: String? {
        return recipe.photoURLLarge ?? recipe.photoURLSmall
    }
    
    init(recipe: Recipe,
         urlAction: @escaping ((String) -> ())) {
        
        self.recipe = recipe
        self.urlAction = urlAction
        
    }
    
    var body: some View {
        
        CardView {
            
            HStack(spacing: Spacing.medium.value) {
                
                if let photoURL {
                    image(url: photoURL)
                }
                
                information()
                
            }
            
        }
        .padding(.horizontal, .large)
        
    }
    
    private func image(url: String) -> some View {
        
        AsyncImageView(
            id: recipe.id,
            url: url
        )
        .aspectRatio(contentMode: .fit)
        .frame(width: 120, height: 120)
        .cornerRadius(.small)
        
    }
    
    private func information() -> some View {
        
        VStack(alignment: .leading) {
            
            iconTitle(
                title: recipe.name,
                icon: "textformat"
            )
            
            iconTitle(
                title: recipe.cuisine,
                icon: "fork.knife"
            )
                        
            links()
                .padding(.top, .medium)
        
        }
        
    }
    
    private func iconTitle(title: String,
                           icon: String) -> some View {
        
        HStack(spacing: Spacing.custom(6).value) {
            
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 18)
                .foregroundStyle(.mint)
            
            Text(title)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
                .appFont(with: .title(.t5))
            
        }
        
    }
    
    private func links() -> some View {
        
        HStack {
            
            if let sourceURL = recipe.sourceURL {
                
                AppButton(
                    title: "Website",
                    image: Image(systemName: "link"),
                    action: {
                        urlAction(sourceURL)
                    }
                )
                
            }
            
            if let youtubeURL = recipe.youtubeURL {
                
                AppButton(
                    title: "Youtube",
                    image: Image(systemName: "link"),
                    action: {
                        urlAction(youtubeURL)
                    }
                )
                
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
}

#Preview {
    
    RecipeView(recipe: .DUMMY_DATA()) { url in
        print(url)
    }

}
