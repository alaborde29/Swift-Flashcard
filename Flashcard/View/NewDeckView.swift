//
//  NewCardView.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 02/04/2024.
//

import SwiftUI

struct NewDeckView: View {
    @StateObject var viewModel = NewDeckViewModel()
    var body: some View {
        VStack {
            Text("New deck")
                .font(.system(size: 32))
                .bold()
                .padding(.top)
            Form {
                TextField("Deck name", text: $viewModel.deckName)
                    .autocorrectionDisabled()
                TextField("Deck description", text: $viewModel.deckDescription)
                Toggle("Advanced", isOn: $viewModel.asBack)
                    .toggleStyle(DefaultToggleStyle())
                if viewModel.asBack {
                }
            }
            
            Button {
                print("lets go")
                viewModel.save()
            }
        label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                Text("Create deck")
                    .foregroundColor(.white)
            }
        }
        .frame(width: 250, height: 50)
        }
        .navigationTitle("New deck")
        .alert(isPresented: $viewModel.showAlert, content: {
            Alert(title: Text("Error"), message: Text(viewModel.error))
        })
    }
}

#Preview {
    NewDeckView()
}
