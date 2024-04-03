//
//  CardView.swift
//  Flashcard
//
//  Created by Alexandre Laborde on 01/04/2024.
//

import SwiftUI

struct Card: View {
    @StateObject var viewModel = CardViewViewModel()
    
    @Binding var degree: Double
    @State private var offset: CGSize = .zero
    @State var dragDirection: Int = 0
    @State var isFlipped = false
    @State var label: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .frame(width: 300, height: 500)
            Text(label)
                .foregroundColor(.white)
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardView: View {
    @StateObject var viewModel = CardViewViewModel()
    
    @State private var offset: CGSize = .zero
    @State var dragDirection: Int = 0
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    
    let durationAndDelay : CGFloat = 0.150
    
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.easeIn(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.easeIn(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.easeIn(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.easeIn(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
    
    var body: some View {
        ZStack {
            Card(degree: $frontDegree, label: "1")
            Card(degree: $backDegree, label: "2")
        }
        .offset(offset)
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.offset = value.translation
                }
                .onEnded { value in
                    let dragThreshold: CGFloat = 100
                    if value.translation.width > dragThreshold {
                        print("right")
                        withAnimation(.spring()) { // Apply spring animation here
                            self.offset = .zero
                        }
                        self.dragDirection = 1
                    } else if value.translation.width < -dragThreshold {
                        print("left")
                        withAnimation(.spring()) { // Apply spring animation here
                            self.offset = .zero
                        }
                        self.dragDirection = -1
                    } else {
                        // Not enough drag, return card to center
                        withAnimation(.bouncy()) { // Apply spring animation here
                            self.offset = .zero
                        }
                    }
                }
        )
        .onTapGesture {
            flipCard()
        }
    }
}

#Preview {
    CardView()
}
