
// VStack - up-down, ZStack - to user, HStack - side to side - sve je View
// sve u {} je funkcija - embedded function (prosledi se sta je u VStack - kreira se TupleView , koji pravi ViewBuilder)
// last argument of everything is a function
// one line of code in function -> return is implicit

import SwiftUI

struct EmojiMemoryGameView: View {
    // da prati promene i reaguje na njih - renderuje sliku ponovo
    @ObservedObject var viewModel: EmojiMemoryGame
        
    var body: some View {
        VStack {
            ScrollView {
                cards
//                Spacer()
//                cardCountAdjusters
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding() // not for everything inside, so for view itself
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(.orange)      // for all in HStack
    }
    
//    var cardCountAdjusters: some View {
//        HStack {
//            cardRemover
//            Spacer()
//            cardAdder
//        }
//        .imageScale(.large)
//        .font(.largeTitle)
//    }
//    
//    func cardCountAdjuster(by offset: Int, symbol: String) ->some View {    // by is name for caller
//        Button(action: {
//            cardCount += offset
//        }, label: {
//            Image(systemName: symbol)
//        })
//        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)  // when this func is disabled
//    }
//    
//    var cardRemover: some View {
//        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
//    }
//    
//    var cardAdder: some View {
//        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
//    }
}

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(card.isFacedUp ? 1 : 0)
            base.fill().opacity(card.isFacedUp ? 0 : 1)
        }
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}

