//
//  NewCardViewViewModel.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 06/04/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class NewCardViewViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var hasBack: Bool = false
    @Published var propositions: [String] = [""]
    @Published var description: String = ""
    @Published var image: String = ""
    @Published var rightAnswer: String = ""
    @Published var backDescription: String = "Enter answer description"
    @Published var color: String = ""
    @Published var showAlert: Bool = false
    @Published var error: String = ""
    
    
    init() {}
    
    func save() {
        guard canSave() else {
            print("error")
            return
        }
        
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let newId = UUID().uuidString
        let newItem = FlashcardItem(
            id: newId,
            hasBack: hasBack,
            description: description,
            image: image,
            color: color,
            backData: FlashcardItemBack(
                id: newId,
                rightAnswer: rightAnswer,
                description: backDescription,
                propositions: propositions
            )
        )
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("decks")
            .document(newId)
            .setData(newItem.asDictionary())
        print("OK !")
    }
    
    func canSave() -> Bool {
        error = ""
        guard !description.trimmingCharacters(in: .whitespaces).isEmpty else {
            error = "Must provide a description"
            showAlert.toggle()
            return false
        }
        guard !hasBack || (!propositions.isEmpty && !propositions.contains("") && propositions.count > 2) else {
            error = "Must provide at least 2 propositions"
            showAlert.toggle()
            return false
        }
        
        return true
    }
    
    func addNewProposition() {
        propositions.append("")
    }
    
    func removeProposition(at index: Int) {
        guard index >= 0 && index < propositions.count else {
            return
        }
        propositions.remove(at: index)
    }
}
