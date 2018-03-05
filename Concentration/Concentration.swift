//
//  Concentration.swift
//  Concentration
//
//  Created by Mike Ngo on 3/2/18.
//  Copyright © 2018 Mike Ngo. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are faced up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // Shuffle the cards
        func shuffledCards(_ cardCount: Int) {
            var arrayShuffle = [Int](repeating: 0, count: cardCount)
            for unshuffledCard in 0..<cardCount {
                let cardItem = Int(arc4random_uniform(UInt32(cardCount)))
                if unshuffledCard != cardItem {
                    cards.swapAt(Array<Any>.Index(arc4random_uniform(UInt32(cards.count))), Array<Any>.Index(arc4random_uniform(UInt32(cards.count))))
                }
                arrayShuffle[cardItem] = unshuffledCard
            }
        }
        shuffledCards(cards.count)
    }
}
