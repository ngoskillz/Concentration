//
//  Concentration.swift
//  Concentration
//
//  Created by Mike Ngo on 3/2/18.
//  Copyright © 2018 Mike Ngo. All rights reserved.
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
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are faced up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
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
