//
//  ContentView.swift
//  MemoryGame
//
//  Created by Samuel Lopez on 3/28/25.
//

import SwiftUI

/// Represents a single card in our memory game
struct MemoryCard: Identifiable, Equatable {
    let id = UUID()
    let value: Int
    var isFaceUp: Bool = false
    var isMatched: Bool = false
}

struct ContentView: View {
    // The number of pairs the user can select
    @State private var selectedNumberOfPairs: Int = 2
    
    // All the cards in our current game
    @State private var cards: [MemoryCard] = []
    
    // Track the index of the first flipped card, if any
    @State private var firstSelectedIndex: Int? = nil
    
    // Options for number of pairs in the game
    private let pairOptions = [2, 4, 6, 8]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Memory Game")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Picker to choose how many pairs
            Picker("Number of Pairs", selection: $selectedNumberOfPairs) {
                ForEach(pairOptions, id: \.self) { pairCount in
                    Text("\(pairCount) pairs").tag(pairCount)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .onChange(of: selectedNumberOfPairs) { _ in
                startNewGame()
            }
            
            // Scrollable grid of cards
            ScrollView {
                LazyVGrid(
                    columns: [GridItem(.flexible()),
                              GridItem(.flexible()),
                              GridItem(.flexible())],
                    spacing: 15
                ) {
                    ForEach(cards.indices, id: \.self) { index in
                        // If a card is matched, it disappears with an opacity transition
                        if !cards[index].isMatched {
                            cardView(for: cards[index])
                                .onTapGesture {
                                    flipCard(at: index)
                                }
                                .transition(.opacity)
                                .animation(.easeInOut(duration: 0.5), value: cards[index].isMatched)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            // New Game button
            Button("New Game") {
                startNewGame()
            }
            .padding()
            .background(Color.blue.opacity(0.7))
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
        .onAppear {
            startNewGame()
        }
    }
    
    // MARK: - Card View

    /// A sub-view that renders a single card with a flip animation.
    private func cardView(for card: MemoryCard) -> some View {
        ZStack {
            if card.isFaceUp {
                // Face-up: show the value
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue.opacity(0.4))
                Text("\(card.value)")
                    .font(.largeTitle)
                    .bold()
            } else {
                // Facedown card
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Text("")
                            .foregroundColor(.white)
                    )
            }
        }
        .frame(height: 100)
        // Rotate 180 degrees on Y axis if the card is facedown
        .rotation3DEffect(Angle.degrees(card.isFaceUp ? 0 : 180), axis: (x: 0, y: 1, z: 0))
        // Animate flipping
        .animation(.easeInOut(duration: 0.5), value: card.isFaceUp)
    }
    
    // MARK: - Game Logic

    /// Prepares a new game with pairs of cards, shuffles them, and resets any existing state.
    private func startNewGame() {
        var newCards: [MemoryCard] = []
        
        // Create pairs
        for value in 1...selectedNumberOfPairs {
            let card1 = MemoryCard(value: value)
            let card2 = MemoryCard(value: value)
            newCards.append(contentsOf: [card1, card2])
        }
        
        // Shuffle the cards
        newCards.shuffle()
        
        self.cards = newCards
        self.firstSelectedIndex = nil
    }
    
    /// Flip a card at the given index and handle matching logic.
    private func flipCard(at index: Int) {
        // Guard against flipping an already matched or face-up card
        guard !cards[index].isMatched, !cards[index].isFaceUp else { return }
        
        // Flip this card face up (with animation)
        withAnimation(.easeInOut(duration: 0.3)) {
            cards[index].isFaceUp = true
        }
        
        // If we already flipped one card, check for a match
        if let firstIndex = firstSelectedIndex {
            if cards[firstIndex].value == cards[index].value {
                // It's a match!
                withAnimation(.easeInOut(duration: 0.3)) {
                    cards[firstIndex].isMatched = true
                    cards[index].isMatched = true
                }
            } else {
                // Not a match: flip them both back down after a delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        cards[firstIndex].isFaceUp = false
                        cards[index].isFaceUp = false
                    }
                }
            }
            // Reset selection
            firstSelectedIndex = nil
        } else {
            // This is the first card
            firstSelectedIndex = index
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
