//
//  Game.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-23.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import Foundation

class Game: ObservableObject {
     var players = [Player]()
    var dealer: Player!
    var currPlayer = 0
    var cardBank = [PlayingCard]()
    var currentCardLocation = 0
    @Published var started = true
    func startGame() {
        print("Game Started")
        var count = 0
        while count<4{
            cardBank.append(contentsOf: PlayingDeck.init().getShuffledDeck())
            count += 1
        }
        cardBank = cardBank.shuffled()
        
        self.dealer = Player.init(id: "dealer", cardsDealt: nil, game: self, isRobot: false )
        for eachPlayer in players{
            var cards = [self.dealCard()]
            cards.append(self.dealCard())
            eachPlayer.dealHand(hand: cards)
        }
        var cards = [self.dealCard()]
        cards.append(self.dealCard())
        self.dealer.dealHand(hand: cards)
        self.started = true
    }
    
    func enrollPlayer(player: Player){
        if player.id == "dealer"{
            return
        }
        player.turnNumber = self.players.count 
        self.players.append(player)
        print(players.count)
    }
    func dealCard() ->  PlayingCard {
        let card = cardBank[currentCardLocation]
        currentCardLocation += 1
        return card
    }
    init() {
        print("FUCKTHIS")
        print(players.count)
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
    
    func splitPlayer(playerNumber: Int, cardsToSplit: [PlayingCard], playerHandToSplit: Int){
        players[playerNumber].cardsDealt[playerHandToSplit] = [cardsToSplit[0]]
        players[playerNumber].dealHand(hand: [cardsToSplit[1]])
    }
    func serviceCurrPlayer(response: turnPosibilities){
        servicePlayer(playerNumber: currPlayer, response: response, playerHandIndex: currPlayer)
    }
    func serviceMe(response: turnPosibilities, player: Int) {
        servicePlayer(playerNumber: player, response: response, playerHandIndex: players[player].currentHand)
    }
    func servicePlayer(playerNumber: Int, response: turnPosibilities, playerHandIndex: Int){
        switch response {
        case turnPosibilities.hit:
            players[playerNumber].dealtCard(card: self.dealCard())
                return
        case turnPosibilities.stay:
            return
        case turnPosibilities.doubleIfPossibleOrHit:
            players[playerNumber].dealtCard(card: self.dealCard())
        case turnPosibilities.doubleIfPossibleOrStand:
            players[playerNumber].dealtCard(card: self.dealCard())
        case turnPosibilities.split:
            splitPlayer(playerNumber: playerNumber, cardsToSplit: players[playerNumber].getHand(), playerHandToSplit: playerHandIndex)
        }
}
}
