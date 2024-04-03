//
//  Deck.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 02/04/2024.
//

import Foundation

class Deck: Codable {
    let size: Int8
    let name: String
    let description: String
    let cards: [FlashcardItem]
    
    init(size: Int8, name: String, description: String, cards: [FlashcardItem]) {
        self.size = size
        self.name = name
        self.description = description
        self.cards = cards
    }
}

