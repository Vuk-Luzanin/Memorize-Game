// private(set) -> only readable

import Foundation


struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        // add numberOfPairsOfCards*2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
    }
    
    mutating func choose(_ card: Card) {         // card je implicitno let -> immutable
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFacedUp.toggle()
    }
    
    func index(of card: Card) -> Int {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0    // FIXME: bogus!
    }
    
    mutating func shuffle() {           // mutating - for mutating self
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFacedUp = true
        var isMatched = false
        let content: CardContent
        
        
        // Za identifikaciju kod hesiranja
        var id: String
        
        // equals - kada se ovako porede sve vrednosti, onda se ni ne mora navoditi
//        static func == (lhs: Card, rhs: Card) -> Bool {
//            return lhs.isFacedUp == rhs.isFacedUp &&
//            lhs.isMatched == rhs.isMatched &&
//            lhs.content == rhs.content
//        }
        
        // toString()
        var debugDescription: String {
            "\(id): \(content) \(isFacedUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
}
