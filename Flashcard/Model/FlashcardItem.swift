//
//  FlashcardItem.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 31/03/2024.
//

import Foundation

class FlashcardItemBack: Codable {
    let rightAnswer: String
    let description: String
}

class FlashcardItem: Codable {
    let hasBack: Bool
    let answer: [String]
    let description: String
    let image: String
    let backData: FlashcardItemBack
}
