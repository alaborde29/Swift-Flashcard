//
//  DeckCollectionView.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 02/04/2024.
//

import SwiftUI
import FirebaseFirestoreSwift

struct DeckCollectionView: View {
    @StateObject var viewModel: DeckCollectionViewModel
    @State var testDeck: Deck = Deck(size: 0, name: "", description: "", cards: [])
//    @FirestoreQuery var deckList: [Deck]
    
    init (userId: String) {
//        self._deckList = FirestoreQuery(collectionPath: "users/\(userId)/decks")
        self._viewModel = StateObject(wrappedValue: DeckCollectionViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            //            if deckList.count <= 0 {
            //                empty
            //            } else {
            //
            //            }
        empty
        }
    }
    
    @ViewBuilder
    var empty: some View {
        VStack {
            Image(systemName: "plus.rectangle.portrait.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 70)
                .rotation3DEffect(.degrees(-10), axis: (x: 0.0, y: 1.0, z: 0.0))
                .foregroundColor(.blue)
                .shadow(radius: 2)
                .padding()
            Text("Why not starting by creating your first deck ?")
                .bold()
                .font(.system(size: 20))
                .multilineTextAlignment(.center)
                .frame(width: 300)
        }
        .navigationTitle("Decks")
        .toolbar {
            Button(action: {
//                viewModel.showingNewItemView = true
            }, label: {
                Image(systemName: "plus")
            })
        }
    }
}

#Preview {
    DeckCollectionView(userId: "")
}
