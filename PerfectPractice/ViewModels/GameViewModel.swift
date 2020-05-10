//
//  Game.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-23.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import Foundation
import Combine
class GameViewModel: ObservableObject {
    @Published var players = [Player]()
    @Published var dealer = Hand.init()
    var currPlayer = 0
    var cardBank = [PlayingCard]()
    var currentCardLocation = 0
    var realPlayer = 1
    var perfectHelper = PerfectStrategyClient()

    
    func startGame() {
        print("Game Started")
        dealInPlayers()
        while currPlayer < realPlayer{
            self.serveNPC(player: players[currPlayer])
            currPlayer += 1
        }
    }
    init() {
        setUpCardBank()
    }
    
    func resetGame(){
        print("reseting game")
        print(players.count)
        for each in players {
            each.hands = [Hand]()
            player.isBust = false
            
        }
        //print(self.dealer.getCard(cardIndex: 0).description)
        self.dealer = Hand()
        self.cardBank = []
        setUpCardBank()
        startGame()
        print(self.dealer.getCard(cardIndex: 0).description)
    }
    
    func dealInPlayers(){
        for eachPlayer in players{
            var cards = [self.dealCard()]
            cards.append(self.dealCard())
            eachPlayer.dealHand(hand: cards)
            eachPlayer.objectWillChange.send()
            print(eachPlayer.hands.count)
        }
        var card = dealCard()
        card.setFaceDown()
        self.dealer.addCard(card: dealCard())
        self.dealer.addCard(card: card)
        print(dealer.getCard(cardIndex: 0).description)
    }
    
    func setUpCardBank(){
        var count = 0
        while count<4{
            cardBank.append(contentsOf: PlayingDeck.init().getShuffledDeck())
            count += 1
        }
        cardBank = cardBank.shuffled()
    }
    func enrollPlayer(player: Player){
        if player.id == "dealer"{
            return
        }
        player.turnNumber = self.players.count 
        self.players.append(player)
    }
    func dealCard() ->  PlayingCard {
        let card = cardBank[currentCardLocation]
        currentCardLocation += 1
        return card
    }
    
    func recontinueGame(){
        var startIndex = realPlayer + 1
        while(startIndex<players.count){
            self.serveNPC(player: players[startIndex])
            startIndex += 1
            print(players[1])
        }
        dealer.cards[1].setFaceUp()
        dealer.objectWillChange.send()
        while(dealer.valueSoFar<16){
            dealer.addCard(card: dealCard())
        }
    }
    
    func splitPlayer(playerNumber: Int, cardsToSplit: [PlayingCard], playerHandToSplit: Int){
        //        players[playerNumber].cardsDealt[playerHandToSplit] = [cardsToSplit[0]]
        //        players[playerNumber].dealHand(hand: [cardsToSplit[1]])
        return
    }
    func handlePlayerInput(response: turnPosibilities, player: Player){
        switch response {
        case turnPosibilities.hit:
            player.dealtCard(card: dealCard())
        case turnPosibilities.stay:
            if(!player.isRobot){
                
                self.recontinueGame()
            }
            return
        case .doubleIfPossibleOrHit:
            player.dealtCard(card: dealCard())
        case turnPosibilities.doubleIfPossibleOrStand:
            player.dealtCard(card: dealCard())
        case turnPosibilities.split:
            //            splitPlayer(playerNumber: playerNumber, cardsToSplit: players[playerNumber].getHand(), playerHandToSplit)
            return
            
        case turnPosibilities.perfectStrategy:
            return
            
        }
        
        if(player.isBust && !player.isRobot){
            self.recontinueGame()
        }
        
        return
    }
    func serveNPC(player: Player){
        while(!player.isBust)
        {
            
            while(!player.hands[player.currentHand].isBust)
            {
                let resp = perfectHelper.getResponse(dealerUpcard: dealer.getCard(cardIndex: 0), playerCards: player.hands[player.currentHand].cards)
                //implement the other stuff breuh 
                if resp == turnPosibilities.stay || resp == turnPosibilities.split || resp == turnPosibilities.doubleIfPossibleOrHit || resp == turnPosibilities.doubleIfPossibleOrStand{
                    
                    return
                }
                handlePlayerInput(response: resp, player: player)
            }
            
        }
        return
    }
    
    func handleRealPlayer(player: Player, response: turnPosibilities) {
        handlePlayerInput(response: response, player: player)
        currPlayer += 1
        recontinueGame()
        return
    }
    
    
}
