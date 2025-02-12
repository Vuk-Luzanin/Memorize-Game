

// jer je deo UI
// gatekeeper izmedju modela i UI -> ViewModel
// $0 is first argument
// promenljive klase se ne inicijalizuju redom -> pa ne smemo jednu promenljivu inicijalizovati drugom
// static ispred imena je da emojis bude globalna promenljiva, ali u  namespaceu nase klase -> time ce se globane promenljive prve inicijalizovati, pa njima mozemo inicijalizovati ostale promenljive
import SwiftUI


class EmojiMemoryGame {
    private static let emojis = ["🤗", "🫠", "😹", "👀", "🗣️", "👨‍🚀", "💅"]
    
    private var model = MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
        return EmojiMemoryGame.emojis[pairIndex]
    }
    
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {      // _ no external name
        model.choose(card)
    }
}
