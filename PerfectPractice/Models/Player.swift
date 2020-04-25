//
//  PlayingHand.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-23.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import Foundation

enum turnPosibilities{
    case hit, stay, split, doubleIfPossibleOrHit, doubleIfPossibleOrStand
}

class Player: ObservableObject {
    let id:String
    @Published var cardsDealt = [[PlayingCard]]()
    var currentHand = 0
    var game: Game
    var turnNumber: Int = -1
    var isRobot = true
    
    init(id: String, cardsDealt: [[PlayingCard]]?, game: Game, isRobot: Bool?) {
        self.id = id
        if let cards = cardsDealt {
            self.cardsDealt = cards
        }
        self.game = game
        self.game.enrollPlayer(player: self)
        if let automate = isRobot {
            self.isRobot = automate
        }
    }
    
    func dealtCard(card: PlayingCard){
        self.cardsDealt[self.currentHand].append(card)
    }
    
    func dealHand(hand: [PlayingCard]){
        cardsDealt.append(hand)
    }
    func getHand() -> [PlayingCard]{
        return cardsDealt[currentHand]
    }
    
    func getHandByIndex(index: Int) -> [PlayingCard]{
        return cardsDealt[index]
    }
    
    func getHands() -> [[PlayingCard]] {
        return cardsDealt
    }
    
    func requestCard(){
        self.game.serviceMe(response: turnPosibilities.hit, player: self.turnNumber)
    }
    
    func getCardByHandCardIndex(handIndex: Int, cardIndex: Int) -> PlayingCard{
        return cardsDealt[handIndex][cardIndex]
    }
}


