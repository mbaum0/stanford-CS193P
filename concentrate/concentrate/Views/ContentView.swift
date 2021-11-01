//
//  ContentView.swift
//  concentrate
//
//  Created by Michael Baumgarten on 10/31/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
            title
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
                .foregroundColor(.red)
            }
            Spacer()
//            HStack {
//                Spacer()
//                themeButtonView(themeName: "transport", iconName: "car", callback: {setTheme("transport")})
//                Spacer()
//                themeButtonView(themeName: "sport", iconName: "bicycle", callback: {setTheme("sport")})
//                Spacer()
//                themeButtonView(themeName: "food", iconName: "mouth", callback: {setTheme("food")})
//                Spacer()
//            }
//            .font(.largeTitle)
//            .padding(.horizontal)
        }
        .padding(.horizontal)
    }

    
    
    var title: some View {
        Text("Concentrate!")
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
            } else {
                shape.fill()
            }
        }
    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
