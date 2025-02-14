//
//  CardView.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import SwiftUI

struct CardView<Content>: View where Content: View {
    
    private let verticalPadding: Spacing
    private let horizontalPadding: Spacing
    private let backgroundColor: Color
    private let cornerRadius: CornerRadius
    private let content: Content
    
    public init(verticalPadding: Spacing = .medium,
                horizontalPadding: Spacing = .medium,
                backgroundColor: Color = .white,
                cornerRadius: CornerRadius = .small2,
                @ViewBuilder content: () -> Content) {
        
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.content = content()
        
    }
 
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(spacing: 0) {
                
                self.content
                    .padding(.vertical, self.verticalPadding)
                    .padding(.horizontal, self.horizontalPadding)
                
                Spacer(minLength: 0)
                
            }
            
        }
        .background(self.backgroundColor)
        .cornerRadius(self.cornerRadius)
        .appShadow()
        
    }
    
}

#Preview("Basic Card View") {
    
    CardView {
        
        HStack {
            
            Label(
                "Person",
                systemImage: "person.fill"
            )
            
            Spacer(minLength: 0)
            
            Image(systemName: "chevron.right")
            
        }
        .foregroundStyle(.mint)
        
    }
    .padding(.horizontal, 32)
    
}
