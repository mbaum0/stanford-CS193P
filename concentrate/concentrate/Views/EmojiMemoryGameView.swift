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
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        gameModel.choose(card)
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
                Pie(startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 20))
                    .padding(DrawingConstants.piePadding)
                    .opacity(DrawingConstants.pieOpacity)
                    .foregroundColor(.blue)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1))
                    //.font(font(in: geometry.size))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp, isVisible: !card.isMatched)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.contentScalingRatio)
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.contentScalingRatio)
    }
    
    private struct DrawingConstants {
        static let contentScalingRatio: CGFloat = 0.70
        static let piePadding: CGFloat = 3
        static let pieOpacity: CGFloat = 0.5
        static let fontSize: CGFloat = 32
        
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
    game.choose(game.cards.first!)
        return EmojiMemoryGameView(gameModel: game)
            .preferredColorScheme(.dark)
    }
}
