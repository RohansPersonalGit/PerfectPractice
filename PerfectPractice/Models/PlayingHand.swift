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

struct Player {
    let id:String
    var cardsDealt = [PlayingCard]()
}
