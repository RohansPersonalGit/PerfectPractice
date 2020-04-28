//
//  HandView.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-27.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import SwiftUI

struct HandView: View {
     var hand:Hand
    var body: some View {
    HStack
        {ForEach(0..<hand.cards.count, id: \.self){
            card in
            VStack(alignment: .leading, spacing: 2) {PlayingCardView(rank: self.hand.getCard(cardIndex: card).rankRaw, suit: self.hand.getCard(cardIndex: card).suit ).rotationEffect(Angle.init(degrees: Double(card*10)))
            .offset(x: multipe(index: card, offset: 15), y: multipe(index: card, offset: 40))
                
            }
            
        }}
    }
}

struct HandView_Previews: PreviewProvider {
    static var previews: some View {
        HandView.init(hand: setUpHandView())
    }
}
func setUpHandView()-> Hand{
    var hand = Hand.init()
    hand.addCard(card: PlayingCard.init(suit: Suit.club, rank: Rank.ace))
    return hand
    
}
