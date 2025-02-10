
// VStack - up-down, ZStack - to user, HStack - side to side - sve je View
// sve u {} je funkcija - embedded function (prosledi se sta je u VStack - kreira se TupleView , koji pravi ViewBuilder)
// last argument of everything is a function

import SwiftUI

struct ContentView: View {
    let emojis: [String] = ["🤗", "🫠", "😹", "👀"]
    var body: some View {
        HStack {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index], isFacedUp: true)
            }
        }
        .foregroundColor(.orange)      // for all in HStack
        .padding()
    }
}

struct CardView: View {
    var content = ""
    @State var isFacedUp = true // crates poites so value can be changed
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFacedUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
            } else {
                base
            }
            Text(content).font(.largeTitle)
        }
        .onTapGesture {
            isFacedUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
