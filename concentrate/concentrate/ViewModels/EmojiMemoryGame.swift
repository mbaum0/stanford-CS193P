//
//  EmojiMemoryGame.swift
//  concentrate
//
//  Created by Michael Baumgarten on 10/31/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

    static let sportEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🥅", "⛳️", "🏹", "🥊", "🥋"]
    
    static let transportEmojis = ["🦼", "🚊", "🛥", "🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛", "🚜", "🛴", "🚲", "🏍", "🚨", "🚔"]
                                  
    static let foodEmojis = ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🍳", "🧀", "🥨"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            sportEmojis[pairIndex]
        }
    }

    // only the viewmodel can see the model due to the 'private' keyword
    // private(set) means other models have read (but not write) permission on the model
    @Published private(set) var model: MemoryGame<String> = createMemoryGame()
    
    // we can also allow anyone else to access our cards via this inline function. This
    // function returns a copy of the cards
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }


    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }

}
