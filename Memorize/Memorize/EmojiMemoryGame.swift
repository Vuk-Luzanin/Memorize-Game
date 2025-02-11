

// jer je deo UI
// gatekeeper izmedju modela i UI -> ViewModel
import SwiftUI

func createCardContent(forPairAtIndex index: Int) -> String {
    return ["🤗", "🫠", "😹", "👀", "🗣️", "👨‍🚀", "💅"][index]
}

class EmojiMemoryGame {
    private var model = MemoryGame(
        numberOfPairsOfCards: 4,
        cardContentFactory: { (index: Int) -> String in
            return ["🤗", "🫠", "😹", "👀", "🗣️", "👨‍🚀", "💅"][index]
        }
    )
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {      // _ no external name
        model.choose(card)
    }
}
