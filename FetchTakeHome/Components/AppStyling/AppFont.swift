//
//  AppFont.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import SwiftUI

enum AppFont {
        
    enum Title {
        
        /// 12 Medium
        case t1
        
        /// 16 Bold
        case t5
        
    }
    
    enum Body {
        
        /// 12
        case b1
        
        /// 16
        case b5

    }

    case title(Title)
    case body(Body)
    
    var font: UIFont {
        
        switch self {
        case .title(let style):
            
            switch style {
            case .t1: return .rounded(ofSize: 12, weight: .medium)
            case .t5: return .rounded(ofSize: 16, weight: .bold)
            }
            
        case .body(let style):
            
            switch style {
            case .b1: return .rounded(ofSize: 12, weight: .regular)
            case .b5: return .rounded(ofSize: 16, weight: .regular)
            }
        }
        
    }
    
}

extension Font {
    
    static func appFont(_ font: AppFont) -> Font {
        
        let uiFont = font.font
        return Font(uiFont)
        
    }
    
}

extension UIFont {
    
    class func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
        let font: UIFont
        
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: size)
        } else {
            font = systemFont
        }
        return font
        
    }
    
}

// Modifier

struct AppFontViewModifier: ViewModifier {
    
    var font: AppFont!
    
    func body(content: Content) -> some View {
        
        content
            .font(.appFont(font))
        
    }
    
}

// Short-hand View Modifier

extension View {
    
    func appFont(with font: AppFont) -> some View {
        modifier(AppFontViewModifier(font: font))
    }
    
}
