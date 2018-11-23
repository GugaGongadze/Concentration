//
//  ViewController.swift
//  Concentration
//
//  Created by Guga Gongadze on 11/19/18.
//  Copyright © 2018 Guga Gongadze. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let gameThemes = [
        "animals": ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯"],
        "sports": ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🎱", "🏓", "⛸", "🥌", "🛹"],
        "objects": ["⌚️", "📱", "💻", "🖥", "⏰", "💡", "🔋", "⌛️", "☎️", "💎"],
        "food": ["🍎", "🍐", "🍇", "🍌", "🍓", "🍒", "🍆", "🍗", "🥨", "🌽"],
        "travel": ["🚗", "🚕", "🚎", "🚃", "✈️", "🛴", "🏰", "🏔", "🚠", "🚀"],
        "flags": ["🇬🇪", "🇩🇪", "🇫🇮", "🇨🇮", "🇳🇮", "🇵🇱", "🇵🇹", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇸🇪", "🇰🇷"],
    ]
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    lazy var currentGameTheme = gameThemes.randomElement()?.value
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        flipCount = 0
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        game.gameScore = 0
        currentGameTheme = gameThemes.randomElement()?.value
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        
        scoreLabel.text = "Score: \(String(game.gameScore))"
    }
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        
        if emoji[card.indentifier] == nil, currentGameTheme!.count > 0 {
            let randomIndex = Int.random(in: 0 ..< currentGameTheme!.count)
            emoji[card.indentifier] = currentGameTheme?.remove(at: randomIndex)
        }
        
        return emoji[card.indentifier] ?? "?"
    }
    
}

