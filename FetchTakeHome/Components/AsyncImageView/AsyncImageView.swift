//
//  AsyncImageView.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import SwiftUI

struct AsyncImageView: View {
    
    @StateObject var viewModel = AsyncImageViewModel()
    
    let id: String
    let url: String
    
    var body: some View {
        
        Group {
            
            if let image = viewModel.image {
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                
            }
            else {
                
                placeholderImage()
                
            }
            
        }
        .onFirstAppear {
            
            self.viewModel.loadImage(
                for: id,
                with: url
            )
            
        }
        
    }
    
    private func placeholderImage() -> some View {
        
        Rectangle()
            .fill(Color(uiColor: .systemGray6))
            .overlay {
                
                Image(systemName: "photo.on.rectangle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 64, height: 64)
                    .foregroundStyle(.black)
                
            }

    }
    
}
