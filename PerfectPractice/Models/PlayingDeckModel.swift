//
//  PlayingDeckModel.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-22.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import Foundation
// simple class teo represent playing deck, realistically could be  a strcut
class PlayingDeck {
    let ranks = [1,2,3,4,5,6,7,8,9,10,11,12,13]
    func getShuffledDeck() -> [PlayingCard]{
        var  cards = [PlayingCard]()
        for each in Suit.allCases{
            for eachRank in Rank.allCases {
                cards.append(PlayingCard(suit: each, rank: eachRank))
            }
        }
        return cards.shuffled()
    }
    
}
//card suits
enum Suit: String, CaseIterable{
    case spade="spades", heart="hearts", diamond="diamonds", club="clubs"
}
// card values
enum Rank: Int, CaseIterable{
    case ace=1, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
}
//playing card struct
struct PlayingCard: Identifiable {
    var id = UUID().uuidString
    let suit:Suit
    var isFaceUp = true
    let rank: Rank
    //rawface value as int
    var rankRaw: Int {
        get {
            return getCardValue(rank: self.rank)
        }
    }
    //print description for debugging
    var description: String {
        return "\(type(of: self))(suit: \(suit), rank: \(rank), id: \(id))"
    }
    //compute value of a card
    func getCardValue(rank: Rank)-> Int{
        if rank==Rank.jack || rank==Rank.queen || rank==Rank.king{
            return 10
        }
        else{
            return rank.rawValue
        }
    }
    //alter ui view
    mutating func setFaceDown(){
        self.isFaceUp = false
    }
    mutating func setFaceUp(){
        self.isFaceUp = true
    }
}



