//
//  DeckInfosView.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 03/04/2024.
//

import SwiftUI

struct DeckInfosView: View {
    @Binding var selectedDeck: Deck?
    @StateObject var viewModel = DeckInfosViewViewModel()
    
    var body: some View {
        VStack {
            Text(selectedDeck?.name ?? "title")
                .fontWeight(.bold)
                .font(.system(size: 30))
            Divider()
            if selectedDeck?.cards.count == 0 { empty } else {
                ScrollView {
                    Text("zebi")
                    List(selectedDeck?.cards ?? [] ) { item in
                        cardListItemView(card: item)
                    }
                }
            }
            Button(action: {
                selectedDeck = nil
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .frame(width: 300, height: 50)
                    Text("Save")
                        .foregroundStyle(.white)
                        .bold()
                }
            })
            .padding(.bottom)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    selectedDeck = nil
                }, label: {
                    Image(systemName: "xmark")
                })
            }
        }
    }
    
    @ViewBuilder
    func cardListItemView(card: FlashcardItem) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(card.description)
                    .font(.body)
                    .lineLimit(1)
            }
        }
    }
    
    @ViewBuilder
    var empty: some View {
        VStack {
            Spacer()
            Button(action: {
                viewModel.showingNewCardView = true
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
            Text("Let's add your first card !")
                .bold()
                .font(.system(size: 20))
                .multilineTextAlignment(.center)
                .frame(width: 300)
            Spacer()
        }
        .navigationTitle("Decks")
        .toolbar {
            Button(action: {
                viewModel.showingNewCardView.toggle()
            }, label: {
                Image(systemName: "plus.app")
            })
        }
        .sheet(isPresented: $viewModel.showingNewCardView) {
            NewCardView()
        }
    }
}

#Preview {
    DeckInfosView(selectedDeck: .constant(nil))
}
