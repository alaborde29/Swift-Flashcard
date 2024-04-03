//
//  DeckCollectionViewModel.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 02/04/2024.
//

import Foundation

class DeckCollectionViewModel: ObservableObject {
    @Published var showingNewDeckView: Bool = false
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
}
