
// VStack - up-down, ZStack - to user, HStack - side to side - sve je View
// sve u {} je funkcija - embedded function (prosledi se sta je u VStack - kreira se TupleView , koji pravi ViewBuilder)
// last argument of everything is a function
// one line of code in function -> return is implicit

import SwiftUI

struct ContentView: View {
    let emojis: [String] = ["🤗", "🫠", "😹", "👀", "🗣️", "👨‍🚀", "💅"]
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                cards
                Spacer()
                cardCountAdjusters
            }
        }
        .padding() // not for everything inside, so for view itself
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index], isFacedUp: true)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)      // for all in HStack
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) ->some View {    // by is name for caller
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)  // when this func is disabled
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
}

struct CardView: View {
    var content = ""
    @State var isFacedUp = true // crates poites so value can be changed
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFacedUp ? 1 : 0)
            base.fill().opacity(isFacedUp ? 0 : 1)
        }
        .onTapGesture {
            isFacedUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
