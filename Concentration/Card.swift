//
//  Card.swift
//  Concentration
//
//  Created by Guga Gongadze on 11/19/18.
//  Copyright © 2018 Guga Gongadze. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var indentifier: Int
    
    static var indentifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        indentifierFactory += 1
        return indentifierFactory
    }
    
    init() {
        self.indentifier = Card.getUniqueIdentifier()
    }
}
