//
//  NewCardViewModel.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 02/04/2024.
//

import Foundation

class NewDeckViewModel: ObservableObject {
    @Published var deckName: String = ""
    @Published var deckDescription: String = ""
    @Published var asBack: Bool = false
    @Published var showAlert: Bool = false
    @Published var error: String = ""
    
    init() {}
    
    func save() {
        guard canSave() else {
            print("error")
            return
        }
        print("OK !")
        //sauvegarder dans la db le truc
    }
    
    func canSave() -> Bool {
        error = ""
        guard !deckName.trimmingCharacters(in: .whitespaces).isEmpty else {
            error = "Must provide a deck name"
            showAlert.toggle()
            return false
        }
        return true
    }
}
