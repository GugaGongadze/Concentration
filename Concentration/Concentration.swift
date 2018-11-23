//
//  Concentration.swift
//  Concentration
//
//  Created by Guga Gongadze on 11/19/18.
//  Copyright © 2018 Guga Gongadze. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            
            return foundIndex
        }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    private var alreadyFlippedCardIdentifiers: [Int] = []
    private(set) var gameScore = 0
    
    private let themes = [
        "animals": ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯"],
        "sports": ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🎱", "🏓", "⛸", "🥌", "🛹"],
        "objects": ["⌚️", "📱", "💻", "🖥", "⏰", "💡", "🔋", "⌛️", "☎️", "💎"],
        "food": ["🍎", "🍐", "🍇", "🍌", "🍓", "🍒", "🍆", "🍗", "🥨", "🌽"],
        "travel": ["🚗", "🚕", "🚎", "🚃", "✈️", "🛴", "🏰", "🏔", "🚠", "🚀"],
        "flags": ["🇬🇪", "🇩🇪", "🇫🇮", "🇨🇮", "🇳🇮", "🇵🇱", "🇵🇹", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇸🇪", "🇰🇷"],
    ]
    
    private(set) var flipCount = 0
    lazy var gameTheme = themes.randomElement()?.value
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): Chosen index is out of range")
        
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

            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "init(\(numberOfPairsOfCards)): You must have at least one pair of cards")
        
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
