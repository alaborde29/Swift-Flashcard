//
//  DeckPreviewView.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 03/04/2024.
//

import SwiftUI

struct DeckPreviewView: View {
    @Binding var deck: Deck
    @Binding var selectedDeck: Deck?
    
    var body: some View {
        ZStack {
            NavigationLink(destination: DeckView(currentDeck: $deck), label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    VStack {
                        Text(deck.name)
                            .bold()
                            .font(.system(size: 25))
                            .foregroundColor(.black)
                        Text("size: " + String(deck.size))
                            .bold()
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .offset(CGSize(width: 0.0, height: 10.0))
                    }
                }
            })
            VStack {
                HStack {
                    Spacer()
                    Menu(content: {
                        Button("Edit") { selectedDeck = deck }
                        NavigationLink("Edit2", destination: DeckView(currentDeck: $deck))
                        Button("Duplicate") {}
                        Button("Delete", role: .destructive) {}
                    },
                         label: {
                        Image(systemName: "ellipsis")
                    })
                    .foregroundColor(.black)
                    .padding()
                    .contentShape(Rectangle())
                }
                Spacer()
            }
        }
        .frame(width: 180 ,height: 130)
    }
}

#Preview {
    DeckPreviewView(deck: .constant(Deck(id: "e", size: 0, name: "String", description: "Voici une description courte du deck", cards: [])), selectedDeck: .constant(nil))
}
