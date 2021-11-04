//
//  Cardify.swift
//  concentrate
//
//  Created by Michael Baumgarten on 11/3/21.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    var isVisible: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.borderWidth).foregroundColor(.green)
            } else if !isVisible {
                shape.opacity(0)
            } else {
                shape.fill().foregroundColor(.red)
            }
            content
                .opacity(isFaceUp ? 1: 0)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 2
    }
}

extension View {
    func cardify(isFaceUp: Bool, isVisible: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp, isVisible: isVisible))
    }
}
