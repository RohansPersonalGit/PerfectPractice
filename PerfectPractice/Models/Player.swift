//
//  PlayingHand.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-23.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import Foundation
import Combine
enum turnPosibilities{
    case hit, stay, split, doubleIfPossibleOrHit, doubleIfPossibleOrStand, perfectStrategy
}

class Hand: ObservableObject{
    var id = UUID().uuidString
    
    @Published var cards=[PlayingCard]()
    var isBust: Bool {
        get {
            return valueSoFar > 21
        }
    }
    var hasAce = false
    var valueSoFar = 0
     func addCard(card: PlayingCard){
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
    @Published var hands = [Hand]()
    var currentHand = 0
    let didChange = PassthroughSubject<Player, Never>()
    var currHandValue = 0
    var game: GameViewModel
    var turnNumber: Int = -1
    var isRobot = true
    var isBust = false
    var numhands = 0
    init(id: String, hands: [Hand]?, game: GameViewModel, isRobot: Bool?) {
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
        assert(self.hands.count != 0)
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
        self.hands.append(Hand())
        for each in hand{
            self.dealtCard(card: each)
        }
        numhands += 1
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
//        assert(self.game.started)
        self.game.handlePlayerInput(response: turnPosibilities.hit, player: self)
    }
    
    func getCardByHandCardIndex(handIndex: Int, cardIndex: Int) -> PlayingCard{
        return hands[handIndex].cards[cardIndex]
    }
}


