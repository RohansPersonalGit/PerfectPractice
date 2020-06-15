//
//  HandView.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-27.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import SwiftUI
//not used here, but will use somewhere 
extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .slide)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

struct HandView: View {
    @ObservedObject var hand:Hand
    @State var opacityHand = 0.0

    
    var body: some View {
        ZStack
            {ForEach(0..<self.hand.cards.count, id: \.self){
                card in
                VStack(alignment: .leading, spacing: 2) {PlayingCardView(rank: self.hand.cards[card].rankRaw, suit: self.hand.cards[card].suit, isFaceUp: self.hand.cards[card].isFaceUp ).rotationEffect(Angle.init(degrees: Double(multiply(index: card, offset: 10))))
                    .offset(x: multiply(index: card, offset: 15), y: multiply(index: card, offset: 40))
                    
                }
                }
                
        }
    }
}

struct HandView_Previews: PreviewProvider {
    static var previews: some View {
        HandView.init( hand: (setUpHandView()))
    }
}
func setUpHandView()-> Hand{
    let hand = Hand.init()
    hand.addCard(card: PlayingCard.init(suit: Suit.club, rank: Rank.ace))
    hand.addCard(card: PlayingCard.init(suit: Suit.club, rank: Rank.ten))
    return hand
    
}


