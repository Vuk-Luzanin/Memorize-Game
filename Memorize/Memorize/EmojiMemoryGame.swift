

// jer je deo UI
// gatekeeper izmedju modela i UI -> ViewModel
// $0 is first argument
// promenljive klase se ne inicijalizuju redom -> pa ne smemo jednu promenljivu inicijalizovati drugom
// static ispred imena je da emojis bude globalna promenljiva, ali u  namespaceu nase klase -> time ce se globane promenljive prve inicijalizovati, pa njima mozemo inicijalizovati ostale promenljive
// ne mogu se zvati metode dok klasa nije inicijalizovana ->  funkcija da bude static
import SwiftUI

// View Model

// ObservableObject -> to make Reactive UI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["🤗", "🫠", "😹", "👀", "🗣️", "👨‍🚀", "💅"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 6) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return EmojiMemoryGame.emojis[pairIndex]
            }
            return "😥"
        }
    }
    
    // moze da se ne navodi
    // set function that will be called when object is changed
    //var objectWillChange: ObservableObjectPublisher
    
    //  @Published -> i ne moramo navoditi objectWillChange
    // sa druge strane cemo navesti @ObservedObject
    @Published private var model = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // to make new mark
    // MARK: -Intends
    
    func shuffle() {
        model.shuffle()
        // moze da se ne navodi
        //objectWillChange.send()         // obavestiti UI da se ponovo izrenderuje
    }
    
    func choose(_ card: MemoryGame<String>.Card) {      // _ no external name
        model.choose(card)
    }
}
