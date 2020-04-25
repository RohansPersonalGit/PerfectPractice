//
//  Dealer.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-22.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import Foundation

class Dealer: Player {
    var cardBank = [PlayingCard]()
    var currentCardLocation = 0
    var currPlayer = 0
    init(game: Game?) {
        super.init(id: "Dealer", cardsDealt: nil, game: game!)
        var count = 0
        while count<4{
            cardBank.append(contentsOf: PlayingDeck.init().getShuffledDeck())
            count += 1
        }
        cardBank = cardBank.shuffled()

    }
    
    func dealCard() ->  PlayingCard {
        let card = cardBank[currentCardLocation]
        currentCardLocation += 1
        return card
    }
    
//    Returns dealer as Player
    func asPlayer()-> Player{
        return Player(id: "dealer", cardsDealt: self.cardsDealt, game: self.game)
    }
    
    
    func handValue(cards: [PlayingCard])-> [Int]{
        var  valueSoFar = 0
        var retValues = [Int]()
        var count = 0
        for each in cards{
            if each.rankRaw > 1{
                valueSoFar = valueSoFar + each.rankRaw
                if valueSoFar > 21{
                    return retValues
                }
            }
            else{
                if (valueSoFar + 11) > 21 {
                    valueSoFar = valueSoFar + each.rankRaw
                }
                else {
                    if (count + 1) < cards.count {
                        var newCount = count + 1
                        var cardArray = [PlayingCard]()
                        let pcard = PlayingCard( suit: each.suit, rank: Rank.ace)
                        cardArray.append(pcard)
                        while(newCount<cards.count){
                            cardArray.append(cards[newCount])
                            newCount += 1
                        }
                        let newCardArray = handValue(cards:cardArray)
                        retValues.append(contentsOf: newCardArray)
                    }
                    else {
                        retValues.append(each.rankRaw + valueSoFar)
                        retValues.append(each.rankRaw + 11)
                    }
                }
            }
            count += 1
        }
        return retValues
    }
}

protocol StakeHolder {
    var id: String {get set}
    var cardsDealt: [[PlayingCard]] {get set}
    var currentHand: Int {get set}
}
