//
//  ContentView.swift
//  concentrate
//
//  Created by Michael Baumgarten on 10/31/21.
//

import SwiftUI

struct ContentView: View {
    @State var emojis = ["transport": ["🦼", "🚊", "🛥", "🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛", "🚜", "🛴", "🚲", "🏍", "🚨", "🚔"],
                 "sport": ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🥅", "⛳️", "🏹", "🥊", "🥋"],
                  "food": ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🍳", "🧀", "🥨"]]

    @State var emojiCount = 21
    @State var currentTheme = "transport"
    
    var themes = ["transport": ["icon": "car"], "sport": ["icon": "bicycle"], "food": ["icon": "mouth"]]
    
    var body: some View {
        VStack {
            title
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[currentTheme]![0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .foregroundColor(.red)
            }
            Spacer()
            HStack {
                Spacer()
                themeButtonView(themeName: "transport", iconName: "car", callback: {setTheme("transport")})
                Spacer()
                themeButtonView(themeName: "sport", iconName: "bicycle", callback: {setTheme("sport")})
                Spacer()
                themeButtonView(themeName: "food", iconName: "mouth", callback: {setTheme("food")})
                Spacer()
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }

    
    
    var title: some View {
        Text("Concentrate!")
    }
    
    func setTheme(_ theme: String) {
        self.currentTheme = theme
        emojis[theme]!.shuffle()
    }
}

struct themeButtonView: View {
    var themeName: String
    var iconName: String
    var callback: () -> Void
    var body: some View {
        Button {
            callback()
        } label: {
            VStack
            {
                Image(systemName: iconName)
                    .padding(.horizontal)
                Text(themeName)
                    .font(.callout)
                
            }
            .cornerRadius(4)
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
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
