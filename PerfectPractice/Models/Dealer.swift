//
//  Dealer.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-22.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import Foundation

class Dealer {
    var players = [PlayingHand]()
    var cardBank = [PlayingCard]()
    var currentCardLocation = 0
    var currPlayer = 0
    var deaderHand = PlayingHand(id: "Dealer")
    init() {
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
    
    func dealPlayers(){
        var count = 0
        while count<4 {
            var player = PlayingHand(id: String(count), cardsDealt: [dealCard()])
            player.cardsDealt.append(dealCard())
            players.append(player)
            count += 1
        }
        self.deaderHand.cardsDealt.append(self.dealCard())
        self.deaderHand.cardsDealt.append(self.dealCard())
    }
    
    func handValue(cards: [PlayingCard])-> [Int]{
        var  valueSoFar = 0
        var retValues = [Int]()
        var count = 0
        for each in cards{
            if each.rank > 1{
                valueSoFar = valueSoFar + each.rank
                if valueSoFar > 21{
                    return retValues
                }
            }
            else{
                if (valueSoFar + 11) > 21 {
                    valueSoFar = valueSoFar + each.rank
                }
                else {
                    if (count + 1) < cards.count {
                        var newCount = count + 1
                        var cardArray = [PlayingCard]()
                        let pcard = PlayingCard(suit: each.suit, rank: 11)
                        cardArray.append(pcard)
                        while(newCount<cards.count){
                            cardArray.append(cards[newCount])
                            newCount += 1
                        }
                        let newCardArray = handValue(cards:cardArray)
                        retValues.append(contentsOf: newCardArray)
                    }
                    else {
                        retValues.append(each.rank + valueSoFar)
                        retValues.append(each.rank + 11)
                    }
                }
            }
            count += 1
        }
        return retValues
    }
}
