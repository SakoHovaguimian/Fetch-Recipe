//
//  OnFirstAppear.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//


import SwiftUI

struct OnFirstAppear: ViewModifier {
    
    @State private var hasAppeared = false
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                guard !hasAppeared else { return }
                hasAppeared = true
                action()
            }
    }
}

extension View {
    
    func onFirstAppear(perform action: @escaping () -> Void) -> some View {
        modifier(OnFirstAppear(action: action))
    }
    
}
