//
//  EmojiMemoryGame.swift
//  concentrate
//
//  Created by Michael Baumgarten on 10/31/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let themes = [
        EmojiTheme(themeName: "sport",
                   content: ["β½οΈ", "π", "π", "βΎοΈ", "π₯", "πΎ", "π", "π", "π₯", "π±", "π", "πΈ", "π", "π", "π₯", "π", "π₯", "β³οΈ", "πΉ", "π₯", "π₯"],
                   numberOfPairs: 4),
        EmojiTheme(themeName: "transport",
                   content: ["π¦Ό", "π", "π₯", "π", "π", "π", "π", "π", "π", "π", "π", "π", "π", "π", "π", "π", "π΄", "π²", "π", "π¨", "π"],
                   numberOfPairs: 8),
        EmojiTheme(themeName: "food",
                   content: ["π", "π", "π", "π", "π", "π", "π", "π", "π", "π", "π", "π₯­", "π", "π₯₯", "π₯", "π", "π", "π₯", "π³", "π§", "π₯¨"],
                  numberOfPairs: 10)
    ]
    
    static func createMemoryGame() -> MemoryGame<String> {
        let theme = themes.randomElement()!
        let randomEmojiSet = theme.getRandomEmojiSet()
        
        return MemoryGame(gameTheme: theme.name, numberOfPairsOfCards: theme.numPairs) { pairIndex in
            randomEmojiSet[pairIndex]
        }
    }
    
    @Published var currentTheme = themes.randomElement()!

    // only the viewmodel can see the model due to the 'private' keyword
    // private(set) means other models have read (but not write) permission on the model
    @Published private(set) var model: MemoryGame<String> = createMemoryGame()
    
    // we can also allow anyone else to access our cards via this inline function. This
    // function returns a copy of the cards
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var themeName: String {
        return model.theme
    }
    
    var score: Int {
        return model.score
    }


    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        self.model = EmojiMemoryGame.createMemoryGame()
    }

}

struct EmojiTheme {
    private(set) var name: String
    private(set) var emojis: [String]
    private(set) var numPairs: Int
    
    init(themeName: String, content: [String], numberOfPairs: Int) {
        name = themeName
        emojis = content
        // if the number of pairs specified is greater than the number of emojis,
        // set numPairs to the number of emojis
        numPairs = numberOfPairs > content.count ? content.count : numberOfPairs
    }
    
    func getRandomEmojiSet() -> [String] {
        return Array(emojis.shuffled()[0..<numPairs])
    }
}
