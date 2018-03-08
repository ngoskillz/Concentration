//
//  ViewController.swift
//  Concentration
//
//  Created by Mike Ngo on 2/28/18.
//  Copyright © 2018 Mike Ngo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func newGameButton(_ sender: UIButton) {
        startNewGame()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emojiChoices = ["😈", "💩", "👽", "🤖", "🥑", "🥩", "👻", "🎃"]
    private var emojiChoicesCopy = [String]()
    private var emoji = [Int:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiChoicesCopy = emojiChoices
    }
    
    // Hooks up the unique identifiers for each card
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoicesCopy.count > 0 {
            emoji[card.identifier] = emojiChoicesCopy.remove(at: emojiChoicesCopy.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    // Logic when starting a new game
    private func startNewGame() {
        // Reset game
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emojiChoicesCopy = emojiChoices
        
        // Reset flip count
        if flipCount > 0 {
            flipCount = 0
        }
        
        // Refresh card lists and backgrounds
        updateViewFromModel()
    }
}

// Extension on Int for arc4random function
extension Int {
    var arc4random: Int {
        if self  > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
