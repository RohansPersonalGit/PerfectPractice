//
//  PlayerView.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-23.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var player:Player
    var body: some View {
        HStack {
            VStack(alignment: .trailing, spacing: 0){
                ForEach(0..<self.player.cardsDealt.count) {
                    index in ZStack {
                        Spacer()
                        ForEach(0..<self.player.getHandByIndex(index: index).count, id: \.self){
                            card in
                            VStack(alignment: .leading, spacing: 2) {PlayingCardView(rank: self.player.getCardByHandCardIndex(handIndex: index,cardIndex: card).rankRaw, suit: self.player.getCardByHandCardIndex(handIndex: index,cardIndex: card).suit ).rotationEffect(Angle.init(degrees: Double(card*10)))
                            .offset(x: multipe(index: card, offset: 15), y: multipe(index: card, offset: 40))
                                
                            }
                            
                        }
                    }
                }
                
                Spacer().frame(height: 45)
                Text(self.player.id).bold().font(Font.system(size: 20))
                Spacer()
            }
            .padding(.all)
            Button(action: {
                self.player.requestCard()
            }, label: {
                Text("Hit ME")
            }).offset(x: CGFloat(player.cardsDealt[0].count*10), y: 0)
        }
    }
}

func multipe(index: Int, offset: Int) -> CGFloat {
    return CGFloat(index*offset)
}

#if DEBUG
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView().environmentObject(player)
    }
}
#endif
var player = Player(id: "Player 1", cardsDealt: [[PlayingCard(suit: Suit.diamond, rank: Rank.jack), PlayingCard(suit: Suit.spade, rank: Rank.ace)]], game: Game.init(), isRobot: false )
