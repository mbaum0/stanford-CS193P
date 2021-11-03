//
//  ContentView.swift
//  concentrate
//
//  Created by Michael Baumgarten on 10/31/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var gameModel: EmojiMemoryGame
    var body: some View {
        VStack {
            title
            
            AspectVGrid(items: gameModel.cards, aspectRatio: 2/3, content: { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            gameModel.choose(card)
                        }
                }
            })
            Spacer()
            HStack {
                Spacer()
                Button {
                    gameModel.newGame()
                } label : {
                    Text("New Game")
                        .font(.largeTitle)
                }
                Spacer()
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }


    var title: some View {
        VStack {
            Text("Concentrate!")
                .font(.title)
            HStack {
                Text("Theme: \(gameModel.themeName)")
                Spacer()
                Text("Score: \(gameModel.score)")
            }
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.borderWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
            .foregroundColor(.red)
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.contentScalingRatio)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 3
        static let contentScalingRatio: CGFloat = 0.75
        
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(gameModel: game)
            .preferredColorScheme(.dark)
    }
}
