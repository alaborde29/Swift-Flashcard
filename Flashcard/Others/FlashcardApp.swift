//
//  FlashcardApp.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 31/03/2024.
//

import SwiftUI
import Firebase

@main
struct FlashcardApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
