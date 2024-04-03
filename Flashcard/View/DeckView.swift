//
//  DeckView.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 03/04/2024.
//

import SwiftUI

struct DeckView: View {
    var currentDeck: Deck
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DeckView(currentDeck: Deck(id: "e", size: 0, name: "String", description: "String", cards: []))
}
