//
//  LoadingView.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        
        ZStack {
            
            Color
                .black
                .opacity(0.5)
                .ignoresSafeArea()
            
            ProgressView()
                .controlSize(.large)
                .tint(.mint)
                .progressViewStyle(.circular)
            
        }
        
    }
    
}
