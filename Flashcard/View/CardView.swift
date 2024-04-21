//
//  CardView.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 01/04/2024.
//

import SwiftUI

struct Card: View {
    @StateObject var viewModel = CardViewViewModel()
    
    @Binding var degree: Double
    @State private var offset: CGSize = .zero
    @State var dragDirection: Int = 0
    @Binding var isFlipped : Bool
    var card: FlashcardItem
    var index: Int

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
            Text("\(index + 1)")
                .foregroundColor(.white)
                .padding(8)
                .background(Color.black.opacity(0.2))
                .cornerRadius(8)
                .offset(x: 120, y: -220)
            VStack {
                if card.hasBack && isFlipped {
                    
                    Text(card.backData.rightAnswer)
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                    
                    Text(card.backData.description)
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                    
                } else {
                    Spacer()
                    Text(card.description)
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                    Spacer()
                    Image("NINO")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 150)
                        .shadow(color: .black, radius: 20)
                        .cornerRadius(10)
                        .padding(.bottom, 50)
                }
            }
            .frame(width: 300, height: 500)
        }
        .frame(width: 300, height: 500)
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardView: View {
    @StateObject var viewModel = CardViewViewModel()
    
    var card: FlashcardItem
    var index: Int
    @State private var offset: CGSize = .zero
    @State var dragDirection: Int = 0
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    @State var isTouchEnabled = true
    var swipeAction: ((Int) -> Void)?
    
    let durationAndDelay : CGFloat = 0.150
    
    func flipCard () {
        DispatchQueue.main.asyncAfter(deadline: .now() + durationAndDelay) { self.isFlipped.toggle() }
        isTouchEnabled = false
        if isFlipped {
            withAnimation(.easeIn(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.easeIn(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.easeIn(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.easeIn(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + durationAndDelay * 2) {
            isTouchEnabled = true
        }
    }
    
    var body: some View {
        ZStack {
            Card(degree: $frontDegree, isFlipped: $isFlipped, card: card, index: index)
            Card(degree: $backDegree, isFlipped: $isFlipped, card: card, index: index)
        }
        .offset(offset)
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.offset = value.translation
                }
                .onEnded { value in
                    let dragThreshold: CGFloat = 100
                    if value.translation.width > dragThreshold {
                        print("right")
                        withAnimation(.spring()) {
                            self.offset = .zero
                        }
                        self.dragDirection = 1
                    } else if value.translation.width < -dragThreshold {
                        print("left")
                        withAnimation(.spring()) {
                            self.offset = .zero
                        }
                        self.dragDirection = -1
                    } else {
                        withAnimation(.bouncy()) {
                            self.offset = .zero
                        }
                    }
                }
        )
        .onTapGesture {
            flipCard()
        }
        .allowsHitTesting(index == 0 ? true : self.isFlipped)
        .allowsHitTesting(isTouchEnabled)
    }
}

#Preview {
    CardView(card: FlashcardItem(id: "198303039d", hasBack: true, description: "Une super longue description que l'on vient utiliser pour montrer des chosers", image: "none", color: "none", backData: FlashcardItemBack(id: "dsedsjlkfn", rightAnswer: "Good", description: "this is why it's good", propositions: ["answer &", "answer 2", "Good", "Answer 4"])), index: 0)
}
