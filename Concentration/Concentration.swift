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
    
    func chooseCard(at index: Int) {
        
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // TODO: Shuffle the cards
    }
}
