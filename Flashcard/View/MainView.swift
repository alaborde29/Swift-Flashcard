//
//  MainView.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 01/04/2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
//        ZStack {
//            ForEach(0..<7) { i in
//                CardView()
//                    .modifier(TopCardShadowModifier(index: i))
//            }
//        }
        accountView
    }
    
    @ViewBuilder
    var accountView: some View {
        TabView {
            DeckCollectionView(userId: viewModel.currentUserId)
                .tabItem { Label("Home", systemImage: "house")}
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.circle")}
        }
    }
}

struct TopCardShadowModifier: ViewModifier {
    let index: Int
    func body(content: Content) -> some View {
        content
            .shadow(radius: index == 0 ? 5 : 0)
    }
}

#Preview {
    MainView()
}
