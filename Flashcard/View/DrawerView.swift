//
//  DrawerView.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 03/04/2024.
//

import SwiftUI

struct DrawerView: View {
    @Binding var isOpen: Bool
    
    var body: some View {
        VStack {
            // Drawer header
            Text("Drawer")
                .font(.headline)
                .padding()
            
            // Drawer items
            List {
                NavigationLink(destination: Text("Item 1")) {
                    Text("Item 1")
                }
                NavigationLink(destination: Text("Item 2")) {
                    Text("Item 2")
                }
                NavigationLink(destination: Text("Item 3")) {
                    Text("Item 3")
                }
            }
            .listStyle(SidebarListStyle())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.secondary)
        .foregroundColor(Color.primary)
        .offset(x: isOpen ? 0 : -UIScreen.main.bounds.width / 2)
        .animation(.default)
        .navigationBarHidden(true)
    }
}


#Preview {
    DrawerView(isOpen: .constant(true))
}
