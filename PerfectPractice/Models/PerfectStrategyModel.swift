//
//  PerfectStrategyModel.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-22.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import Foundation

class PerfectStrategyClient {
    let dealerUpards = [2,3,4,5,6,7,8,9,10,1]
    let hardTotals = [8,9,10,11,12,13,14,15,16,17]
    var hardTotalStrateChart = [[turnPosibbilities]]()
    // first row is ilike a header row repping dealer upcard
    //first number of eevery row after that repsresents twhat your card is
    let headerRow = 0
    let dealerHardTotalsFrom5 = 1
    let dealerAceOffsetBegining = 18
    let pairsSplitting = 26
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
    [21,2,2,2,2,2,2,2,2,2,2],
    [2,1,1,1,1,4,4,1,1,1,1], //this is the ace offset begninng
    [3,1,1,1,1,4,4,1,1,1,1],
    [4,1,1,1,4,4,4,1,1,1,1],
    [5,1,1,1,4,4,4,1,1,1,1],
    [6,1,1,4,4,4,4,1,1,1,1],
    [7,1,2,5,5,5,5,2,2,1,1],
    [8,2,2,2,2,2,2,2,2,2,2],
    [9,2,2,2,2,2,2,2,2,2,2],
    [10,2,2,2,2,2,2,2,2,2,2],
    [1 , 1,3,3,3,3,3,3,3,3,3,3], //Pair Splitting offset begining
    [2 , 2,1,3,3,3,3,3,3,1,1,1],
    [3 , 3,1,3,3,3,3,3,3,1,1,1],
    [4 , 4,1,1,1,1,3,3,1,1,1,1],
    [5 , 5,1,4,4,4,4,4,4,4,4,1],
    [6 , 6,1,3,3,3,3,3,1,1,1,1],
    [7 , 7,1,3,3,3,3,3,3,1,1,1],
    [8 , 8,3,3,3,3,3,3,3,3,3,3],
    [9, 9,2,3,3,3,3,3,2,3,3,2],
    [10,10,2,2,2,2,2,2,2,2,2,2]]

    
    func setStaysForHardTotals() {
        var count = 0
        while count < dealerUpards.count{
            self.hardTotalStrateChart[17-8][count] = turnPosibbilities.stay
            count+=1
        }
        count = 13-8
        while count < (hardTotals.count-1){
            var xCount = 0
            while(xCount<(6-2)){
                hardTotalStrateChart[count][xCount] = turnPosibbilities.stay
                xCount+=1
            }
        }
        hardTotalStrateChart[(12-8)][2] = turnPosibbilities.stay
        hardTotalStrateChart[(12-8)][3] = turnPosibbilities.stay
        hardTotalStrateChart[(12-8)][4] = turnPosibbilities.stay
    }
    
    func getPerfectAction(code: Int)-> turnPosibbilities{
        switch code {
        case 1:
            return turnPosibbilities.hit
        case 2:
        return turnPosibbilities.stay
            case 3:
            return turnPosibbilities.split
            case 4:
            return turnPosibbilities.doubleIfPossibleOrHit
            case 5:
                return turnPosibbilities.dobuleifPossibleOrStand
        default:
            return turnPosibbilities.stay
    }
    
}
}
