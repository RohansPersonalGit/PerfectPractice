//
//  PlayingDeckModel.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-22.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import Foundation
class PlayingDeck {
    let suits = ["Spade", "Heart", "Diamond", "Club"]
    let ranks = [1,2,3,4,5,6,7,8,9,10,11,12,13]
    
    func getShuffledDeck() -> [PlayingCard]{
        var  cards = [PlayingCard]()
        for each in suits{
            for eachRank in ranks {
                cards.append(PlayingCard(suit: each, rank: eachRank))
            }
        }
        return cards.shuffled()
    }
    
}

struct PlayingCard {
    let suit:String
    let rank: Int
}
func getCardValue(rank: Int)-> Int{
    if rank==11 || rank==12 || rank==13{
        return 10
    }
    else{
        return rank
    }
}

