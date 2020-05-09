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
    @EnvironmentObject var hand:Hand
    var body: some View {
        ZStack
            {ForEach(0..<hand.cards.count, id: \.self){
                card in
                VStack(alignment: .leading, spacing: 2) {PlayingCardView(rank: self.hand.getCard(cardIndex: card).rankRaw, suit: self.hand.getCard(cardIndex: card).suit ).rotationEffect(Angle.init(degrees: Double(card*10)))
                    .offset(x: multiply(index: card, offset: 15), y: multiply(index: card, offset: 40))
                    
                }
                
                }
                
        }.animation(.easeInOut(duration: 2 ))
    }
}

struct HandView_Previews: PreviewProvider {
    static var previews: some View {
        HandView.init().environmentObject(setUpHandView())
    }
}
func setUpHandView()-> Hand{
    let hand = Hand.init()
    hand.addCard(card: PlayingCard.init(suit: Suit.club, rank: Rank.ace))
    hand.addCard(card: PlayingCard.init(suit: Suit.club, rank: Rank.ten))
    return hand
    
}
