//
//  PerfectStrategyModel.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-22.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import Foundation
//find the best possible move given the blackjack cards class 
class PerfectStrategyClient {
    let dealerHardTotalsFrom5 = 1
    let aceOffsetTotalBeginIndex = 18
    let pairsSplittingOffsetBegining = 26
    var hards = [[1,2,3,4,5,6,7,8,9,10],
                 [5,1,1,1,1,1,1,1,1,1,1],
                 [6,1,1,1,1,1,1,1,1,1,1],
                 [7,1,1,1,1,1,1,1,1,1,1],
                 [8,1,1,1,1,1,1,1,1,1,1],
                 [9,1,1,4,4,4,4,1,1,1,1],
                 [10,1,4,4,4,4,4,4,4,4,1,],
                 [11,1,4,4,4,4,4,4,4,4,4],
                 [12,1,1,1,2,2,2,1,1,1,1],
                 [13,1,2,2,2,2,2,1,1,1,1],
                 [14,1,2,2,2,2,2,1,1,1,1],
                 [15,1,2,2,2,2,2,1,1,1,1],
                 [16,1,2,2,2,2,2,1,1,1,1],
                 [17,2,2,2,2,2,2,2,2,2,2],
                 [18,2,2,2,2,2,2,2,2,2,2],
                 [19,2,2,2,2,2,2,2,2,2,2],
                 [20,2,2,2,2,2,2,2,2,2,2],
                 [21,2,2,2,2,2,2,2,2,2,2], //this row is use
        [2,1,1,1,1,4,4,1,1,1,1], //this is the ace offset begninng
        [3,1,1,1,1,4,4,1,1,1,1],
        [4,1,1,1,4,4,4,1,1,1,1],
        [5,1,1,1,4,4,4,1,1,1,1],
        [6,1,1,4,4,4,4,1,1,1,1],
        [7,1,2,5,5,5,5,2,2,1,1],
        [8,2,2,2,2,2,2,2,2,2,2],
        [9,2,2,2,2,2,2,2,2,2,2],
        [10,2,2,2,2,2,2,2,2,2,2],
        [1,3,3,3,3,3,3,3,3,3,3], //Pair Splitting offset begining
        [2,1,3,3,3,3,3,3,1,1,1],
        [3,1,3,3,3,3,3,3,1,1,1],
        [4,1,1,1,1,3,3,1,1,1,1],
        [5,1,4,4,4,4,4,4,4,4,1],
        [6,1,3,3,3,3,3,1,1,1,1],
        [7,1,3,3,3,3,3,3,1,1,1],
        [8,3,3,3,3,3,3,3,3,3,3],
        [9,2,3,3,3,3,3,2,3,3,2],
        [10,2,2,2,2,2,2,2,2,2,2]]
    
    func getResponse(dealerUpcard: PlayingCard, playerCards: [PlayingCard])-> turnPosibilities{
        let offsetDealerUpCard = dealerUpcard.rankRaw
        var offsetPlayerCards = 0
        if(playerCards.count == 2){
            if(playerCards[0].rankRaw==playerCards[1].rankRaw){
                offsetPlayerCards += pairsSplittingOffsetBegining
                offsetPlayerCards += playerCards[0].rankRaw
            }
            else if (playerCards[0].rank == Rank.ace || playerCards[1].rank == Rank.ace){
                //substract starting card value and ace raw value to find offset
                offsetPlayerCards = aceOffsetTotalBeginIndex - 2 - 1
                for each in playerCards{
                    offsetPlayerCards += each.rankRaw
                }
            }
            else {
                offsetPlayerCards = dealerHardTotalsFrom5 - 5
                for each in playerCards {
                    //implement handle ace
                    offsetPlayerCards += each.rankRaw
                }
            }
        }
        else {
            offsetPlayerCards = dealerHardTotalsFrom5 - 5
            for each in playerCards {
                //implement handle ace
                offsetPlayerCards += each.rankRaw
            }
        }
        return getPerfectAction(code: hards[offsetPlayerCards][offsetDealerUpCard])
    }
    func getPerfectAction(code: Int)-> turnPosibilities{
        switch code {
        case 1:
            return turnPosibilities.hit
        case 2:
            return turnPosibilities.stay
        case 3:
            return turnPosibilities.split
        case 4:
            return turnPosibilities.doubleIfPossibleOrHit
        case 5:
            return turnPosibilities.doubleIfPossibleOrStand
        default:
            return turnPosibilities.stay
        }
        
    }
}
