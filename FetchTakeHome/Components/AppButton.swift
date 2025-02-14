//
//  AppButton.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import SwiftUI

struct AppButton: View {
    
    var title: String
    var image: Image?
    var action: (() -> ())
    
    init(title: String,
         image: Image? = nil,
         action: @escaping () -> ()) {
        
        self.title = title
        self.image = image
        self.action = action
        
    }
    
    var body: some View {
        
        HStack {
            
            if let image = image {
                image
            }
            
            Text(title)
                .appFont(with: .title(.t1))
                .lineLimit(1)
                .minimumScaleFactor(0.6)
            
        }
        .padding(.vertical, Spacing.small.value)
        .padding(.horizontal, Spacing.small.value)
        .foregroundStyle(.white)
        .background(.mint)
        .cornerRadius(.small)
        .asButton {
            action()
        }
        
    }
    
}

struct ButtonStyleViewModifier: ButtonStyle {
    
    let scale: CGFloat
    let opacity: Double
    let brightness: Double
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .scaleEffect(configuration.isPressed ? self.scale : 1)
            .animation(.interpolatingSpring(stiffness: 200, damping: 15), value: configuration.isPressed)
            .opacity(configuration.isPressed ? self.opacity : 1)
            .brightness(configuration.isPressed ? self.brightness : 0)
        
    }
    
}

extension View {
    
    func asButton(scale: CGFloat = 0.95,
                  opacity: Double = 1,
                  brightness: Double = 0,
                  action: @escaping () -> Void) -> some View {
        
        Button(action: {
            
            action()
            
        }) {
            self
        }
        .buttonStyle(
            ButtonStyleViewModifier(
                scale: scale,
                opacity: opacity,
                brightness: brightness
            )
        )
        
    }
    
}

#Preview {
    
    VStack {
        
        AppButton(title: "App Button") {
            print("Tapping")
        }
        
        AppButton(title: "App Button",
                  image: Image(systemName: "person.fill")) {
            
            print("Tapping")
            
        }
        
    }
    
}
