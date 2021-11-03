//
//  ContentView.swift
//  concentrate
//
//  Created by Michael Baumgarten on 10/31/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var GameModel: EmojiMemoryGame
    var body: some View {
        VStack {
            title
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(GameModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                GameModel.choose(card)
                            }
                    }
                }
                .foregroundColor(.red)
            }
            Spacer()
            HStack {
                Spacer()
                Button {
                    GameModel.newGame()
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
                Text("Theme: \(GameModel.themeName)")
                Spacer()
                Text("Score: \(GameModel.score)")
            }
        }
    }
    
//    func setTheme(_ theme: String) {
//        self.currentTheme = theme
//        emojis[theme]!.shuffle()
//    }
//}
//
//struct themeButtonView: View {
//    var themeName: String
//    var iconName: String
//    var callback: () -> Void
//    var body: some View {
//        Button {
//            callback()
//        } label: {
//            VStack
//            {
//                Image(systemName: iconName)
//                    .padding(.horizontal)
//                Text(themeName)
//                    .font(.callout)
//
//            }
//            .cornerRadius(4)
//        }
//    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(GameModel: game)
            .preferredColorScheme(.dark)
    }
}
