//
//  NewCardView.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 06/04/2024.
//

import SwiftUI

struct NewCardView: View {
    @StateObject var viewModel = NewCardViewViewModel()
    let colors: [String] = ["red", "blue", "green", "yellow", "orange", "purple"]
    
    var body: some View {
        VStack {
        }
        VStack {
            Text("New card")
                .font(.system(size: 32))
                .bold()
                .padding(.top)
            Form(content: {
                TextField("Description", text: $viewModel.description)
                TextField("Images", text: $viewModel.image)
                Picker("Select a color", selection: $viewModel.color) {
                    ForEach(colors, id: \.self) { color in
                        Text(color)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                Toggle("Quiz mode", isOn: $viewModel.hasBack)
                    .toggleStyle(DefaultToggleStyle())
                if viewModel.hasBack {
                    Picker("Right answer", selection: $viewModel.rightAnswer) {
                        ForEach(viewModel.propositions, id: \.self) { proposition in
                            Text(proposition)
                        }
                    }
                    List {
                        ForEach(viewModel.propositions.indices, id: \.self) { index in
                            HStack {
                                TextField("Proposition \(index + 1)", text: $viewModel.propositions[index])
                                    .autocorrectionDisabled()
                                Button(action: {
                                    withAnimation {
                                        if viewModel.propositions.count > 1 {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                viewModel.removeProposition(at: index)
                                            }
                                        }
                                    }
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(viewModel.propositions.count > 1 ? .red : .gray)
                                }
                            }
                        }
                        Button(action: {
                            viewModel.addNewProposition()
                        }) {
                            Label("Add Proposition", systemImage: "plus")
                        }
                        .disabled(viewModel.propositions.count >= 4 ? true : false)
                    }
                    TextEditor(text: $viewModel.backDescription)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: .infinity)
                }
            })
            Button {
                print("lets go")
                viewModel.save()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                    Text("Create card")
                        .foregroundColor(.white)
                }
            }
            .frame(width: 250, height: 50)
        }
        .alert(isPresented: $viewModel.showAlert, content: {
            Alert(title: Text("Error"), message: Text(viewModel.error))
        })
    }
}

#Preview {
    NewCardView()
}
