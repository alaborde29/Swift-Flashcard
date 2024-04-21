//
//  FlashcardItem.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 31/03/2024.
//

import Foundation

struct FlashcardItemBack: Codable, Identifiable {
    let id: String
    let rightAnswer: String
    let description: String
    let propositions: [String]
}

struct FlashcardItem: Codable, Identifiable {
    let id: String
    let hasBack: Bool
    let description: String
    let image: String
    let color: String
    let backData: FlashcardItemBack
}
