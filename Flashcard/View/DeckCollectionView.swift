//
//  DeckCollectionView.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 02/04/2024.
//

import SwiftUI
import FirebaseFirestoreSwift


// test function for dummy values
func initTab() -> [Deck] {
    var testDeckTab = [Deck]()
    
    for i in 0..<20 {
        let deck = Deck(id: String(i), size: 0, name: "TheDeck" + String(i), description: "This is a super deck damn", cards: [])
        testDeckTab.append(deck)
    }
    
    return testDeckTab
}

struct DeckCollectionView: View {
    @StateObject var viewModel: DeckCollectionViewModel
    @State var testDeck: Deck = Deck(id: "eee", size: 0, name: "TheDeck", description: "This i s a super deck damn", cards: [FlashcardItem(id: "198303039d", hasBack: true, description: "Une super longue description que l'on vient utiliser pour montrer des chosers", image: "none", color: "none", backData: FlashcardItemBack(id: "dsedsjlkfn", rightAnswer: "Good", description: "this is why it's good", propositions: ["answer &", "answer 2", "Good", "Answer 4"])), FlashcardItem(id: "198303039d", hasBack: true, description: "Une super longue description que l'on vient utiliser pour montrer des chosers", image: "none", color: "none", backData: FlashcardItemBack(id: "dsedsjlkfn", rightAnswer: "Good", description: "this is why it's good", propositions: ["answer &", "answer 2", "Good", "Answer 4"]))])
    //    @FirestoreQuery var deckList: [Deck]
    @State var testDeckTab: [Deck] = initTab()
    @State var selectedDeck: Deck?
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    
    init (userId: String) {
        //        self._deckList = FirestoreQuery(collectionPath: "users/\(userId)/decks")
        self._viewModel = StateObject(wrappedValue: DeckCollectionViewModel(userId: userId))
    }
    
    var body: some View {
        if selectedDeck != nil {
            DeckInfosView(selectedDeck: $selectedDeck)
        } else {
            NavigationView {
                //            if deckList.count <= 0 {
                //                empty
                //            } else {
                //
                //            }
                if testDeck.size == 0 {
                    VStack {
                        ScrollView {
                            HStack {
                                Text("Category")
                                    .fontWeight(.bold)
                                    .font(.system(size: 25))
                                Spacer()
                            }
                            .padding(.horizontal)
                                
                            Divider()
                            LazyVGrid(columns: columns, spacing: 20) {
                                // if a deck is cloned the id must change (+1 then)
                                ForEach($testDeckTab, id: \.self) { deck in
                                    DeckPreviewView(deck: deck, selectedDeck: $selectedDeck)
                                        .aspectRatio(1.0, contentMode: .fit)
                                }
                            }
                            .padding() // Add padding for better visual appearance
                        }
                        
                    }
                    .navigationTitle("Decks")
                    .toolbar {
                        Menu(content: {
                            Button (action: {
                                viewModel.showingNewDeckView.toggle()
                            }, label: {
                                Label("Add a new deck", systemImage: "plus.app")
                            })
                            Section("Sort by") {
                                Button (action: {
                                    
                                }, label: {
                                    Label("Alphabetic", systemImage: "ellipsis.circle")
                                })
                                Button (action: {
                                    
                                }, label: {
                                    Label("When created", systemImage: "ellipsis.circle")
                                })
                                Button (action: {
                                    
                                }, label: {
                                    Label("Last opened", systemImage: "ellipsis.circle")
                                })
                            }
                        }, label: {
                            Image(systemName: "ellipsis.circle")
                        })
                    }
                    .sheet(isPresented: $viewModel.showingNewDeckView) {
                        NewDeckView()
                    }
                } else {empty}
            }
        }
    }
    
    @ViewBuilder
    var empty: some View {
        VStack {
            Button(action: {
                viewModel.showingNewDeckView  = true
            }, label: {
                Image(systemName: "plus.rectangle.portrait.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70)
                    .rotation3DEffect(.degrees(-10), axis: (x: 0.0, y: 1.0, z: 0.0))
                    .foregroundColor(.blue)
                    .shadow(radius: 2)
                    .padding()
            })
            Text("Why not starting by creating your first deck ?")
                .bold()
                .font(.system(size: 20))
                .multilineTextAlignment(.center)
                .frame(width: 300)
        }
        .navigationTitle("Decks")
        .toolbar {
            Button(action: {
                viewModel.showingNewDeckView.toggle()
            }, label: {
                Image(systemName: "plus.app")
            })
        }
        .sheet(isPresented: $viewModel.showingNewDeckView) {
            NewDeckView()
        }
    }
}

#Preview {
    DeckCollectionView(userId: "")
}
