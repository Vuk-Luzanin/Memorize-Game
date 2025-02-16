// private(set) -> only readable

import Foundation


struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        // add numberOfPairsOfCards*2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
    
    }
    
    mutating func shuffle() {           // mutating - for mutating self
        cards.shuffle()
    }
    
    struct Card {
        var isFacedUp = true
        var isMatched = false
        let content: CardContent
    }
}
