//
//  DeckView.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 03/04/2024.
//

import SwiftUI

struct DeckView: View {
    @Binding var currentDeck: Deck
    var body: some View {
        VStack {
            Text(currentDeck.name)
                .font(.title)
                .bold()
            ZStack {
                ForEach(currentDeck.cards.indices.reversed(), id: \.self) { index in
                    CardView(card: currentDeck.cards[index], index: index, swipeAction: { direction in
                        if direction == 1 {
                            let card = currentDeck.cards.remove(at: index)
                            currentDeck.cards.append(card)
                            print("swipe right")
                        } else if direction == -1 {
                            let card = currentDeck.cards.remove(at: index)
                            currentDeck.cards.insert(card, at: 0)
                            print("swipe left")
                        }
                    })
                }            }
            .shadow(radius: 5)
        }
    }
}

#Preview {
    DeckView(currentDeck: .constant(Deck(id: "e", size: 0, name: "String", description: "String", cards: [FlashcardItem(id: "198303039d", hasBack: true, description: "Une super longue description que l'on vient utiliser pour montrer des chosers", image: "none", color: "none", backData: FlashcardItemBack(id: "dsedsjlkfn", rightAnswer: "Good", description: "this is why it's good", propositions: ["answer &", "answer 2", "Good", "Answer 4"])), FlashcardItem(id: "198303039d", hasBack: true, description: "random desc", image: "none", color: "none", backData: FlashcardItemBack(id: "dsedsjlkfn", rightAnswer: "Good", description: "this is why it's good", propositions: ["answer &", "answer 2", "Good", "Answer 4"]))])))
}
