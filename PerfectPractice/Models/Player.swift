//
//  PlayingHand.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-23.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import Foundation

enum turnPosibilities{
    case hit, stay, split, doubleIfPossibleOrHit, doubleIfPossibleOrStand, perfectStrategy
}

struct Hand: Identifiable {
    var id = UUID()
    
    var cards=[PlayingCard]()
    var isBust: Bool {
        get {
            return valueSoFar > 21
        }
    }
    var hasAce = false
    var valueSoFar = 0
    mutating func addCard(card: PlayingCard){
        self.cards.append(card)
        self.valueSoFar += card.rankRaw
        if card.rank == Rank.ace {
            hasAce = true
        }
    }
    
    func getCard(cardIndex: Int)-> PlayingCard{
        return cards[cardIndex]
    }
}

class Player: ObservableObject {
    let id:String
     var hands = [Hand]()
    var currentHand = 0
    var currHandValue = 0
    var game: Game
    var turnNumber: Int = -1
    var isRobot = true
    var isBust = false
    init(id: String, hands: [Hand]?, game: Game, isRobot: Bool?) {
        self.id = id
        self.game = game
        self.game.enrollPlayer(player: self)
        if let automate = isRobot {
            self.isRobot = automate
        }
        if let cards = hands {
            self.hands.append(contentsOf: cards)
        }
    }
    func decideStrategy(handIndex: Int)-> turnPosibilities{
        //when you return a stay make sure you ++ your curr hand value
        if(self.isRobot){
            return turnPosibilities.perfectStrategy
        }else {
            return turnPosibilities.hit
        }
    }
    

    func dealtCard(card: PlayingCard){
        self.hands[currentHand].addCard(card: card)
        if self.hands[currentHand].isBust {
            if (hands.count == 1){
                self.isBust = true
            }
            else {
                 currentHand += 1
            }
        }
    }
    
    func dealHand(hand: [PlayingCard]){
        var handToAdd = Hand.init()
        self.hands.append(handToAdd)
        for each in hand{
            self.dealtCard(card: each)
        }
    }
    func getHand() -> Hand{
        return self.hands[currentHand]
    }
    
    func getHandByIndex(index: Int) -> Hand{
        return self.hands[index]
    }
    
    func getHands() -> [Hand]{
        return hands
    }
    
    func requestCard(){
        self.game.handlePlayerInput(response: turnPosibilities.hit, player: self)
    }
    
    func getCardByHandCardIndex(handIndex: Int, cardIndex: Int) -> PlayingCard{
        return hands[handIndex].cards[cardIndex]
    }
}


