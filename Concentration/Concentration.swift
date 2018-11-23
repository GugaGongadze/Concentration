//
//  Concentration.swift
//  Concentration
//
//  Created by Guga Gongadze on 11/19/18.
//  Copyright © 2018 Guga Gongadze. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var alreadyFlippedCardIdentifiers: [Int] = []
    var gameScore = 0
    let themes = [
        "animals": ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯"],
        "sports": ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🎱", "🏓", "⛸", "🥌", "🛹"],
        "objects": ["⌚️", "📱", "💻", "🖥", "⏰", "💡", "🔋", "⌛️", "☎️", "💎"],
        "food": ["🍎", "🍐", "🍇", "🍌", "🍓", "🍒", "🍆", "🍗", "🥨", "🌽"],
        "travel": ["🚗", "🚕", "🚎", "🚃", "✈️", "🛴", "🏰", "🏔", "🚠", "🚀"],
        "flags": ["🇬🇪", "🇩🇪", "🇫🇮", "🇨🇮", "🇳🇮", "🇵🇱", "🇵🇹", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇸🇪", "🇰🇷"],
    ]
    var flipCount = 0
    lazy var gameTheme = themes.randomElement()?.value
    
    func chooseCard(at index: Int) {
        flipCount += 1
        let currentCardIdentifier = cards[index].indentifier
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // one card is face up
                
                let oneAndOnlyFaceUpCardIdentifier = cards[matchIndex].indentifier
                
                // Check if cards match
                if oneAndOnlyFaceUpCardIdentifier == currentCardIdentifier  {
                    gameScore += 2
                    if let index = alreadyFlippedCardIdentifiers.index(of: currentCardIdentifier) {
                        alreadyFlippedCardIdentifiers.remove(at: index)
                    }
                    
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                } else {                    
                    if alreadyFlippedCardIdentifiers.contains(currentCardIdentifier) {
                        gameScore -= 1
                    } else {
                        alreadyFlippedCardIdentifiers.append(currentCardIdentifier)
                    }
                    
                    if alreadyFlippedCardIdentifiers.contains(oneAndOnlyFaceUpCardIdentifier) {
                        gameScore -= 1
                    } else {
                        alreadyFlippedCardIdentifiers.append(oneAndOnlyFaceUpCardIdentifier)
                    }
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil

            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
