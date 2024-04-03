//
//  Deck.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 02/04/2024.
//

import Foundation

class Deck: Codable, Hashable {
    let id: String
    let size: Int8
    let name: String
    let description: String
    let cards: [FlashcardItem]
    let creationDate: TimeInterval
    let lastModification: TimeInterval
    let category: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(creationDate)
      }
    
    static func == (lhs: Deck, rhs: Deck) -> Bool {
       return lhs.id == rhs.id
     }
    
    init(id: String, size: Int8, name: String, description: String, cards: [FlashcardItem]) {
        self.id = id
        self.size = size
        self.name = name
        self.description = description
        self.cards = cards
        self.creationDate = 0
        self.lastModification = 0
        self.category = ""
    }
}

