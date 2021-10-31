//
//  ContentView.swift
//  concentrate
//
//  Created by Michael Baumgarten on 10/31/21.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🦼", "🚊", "🛥"]
    var body: some View {
        HStack {
            ForEach(emojis, content: { emoji in
                CardView(content: emoji)
            })
        }
    }
}


struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    var body: some View {
        ZStack {
            let shape = Circle()
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
