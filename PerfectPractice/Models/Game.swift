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
    var dealer = Hand()
    var currPlayer = 0
    var cardBank = [PlayingCard]()
    var currentCardLocation = 0
    var realPlayer = 1
    var perfectHelper = PerfectStrategyClient()
    @Published var started = true
    
    func startGame() {
        print("Game Started")
        setUpCardBank()
        dealInPlayers()
        self.started = true
        while currPlayer < realPlayer{
            self.serveNPC(player: players[currPlayer])
            currPlayer += 1
        }
    }
    
    func dealInPlayers(){
        for eachPlayer in players{
            var cards = [self.dealCard()]
            cards.append(self.dealCard())
            eachPlayer.dealHand(hand: cards)
        }
        dealer.addCard(card: dealCard())
        dealer.addCard(card: dealCard())
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
                if resp == turnPosibilities.stay {
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
