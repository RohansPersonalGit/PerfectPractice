//
//  PlayerView.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-23.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import SwiftUI

struct PlayerView: View {
    @ObservedObject var player:Player
    var body: some View {
        HStack {
            VStack(alignment: .trailing, spacing: 0){
                ForEach(0..<self.player.hands.count, id: \.self) {
                    index in ZStack {
                        Spacer()
                        HandView.init(hand: self.player.hands[index])
                    }
                }
                Spacer().frame(height: 45)
                Text(self.player.id).bold().font(Font.system(size: 20))
                Spacer()
            }
            .padding(.all)
            if !player.isRobot{
                VStack{Button(action: {
                    self.player.requestCard()
                }, label: {
                    Text("Hit Me!")
                })
                    Button(action: {
                        self.player.handleInput(turn: turnPosibilities.stay)
                        self.player.objectWillChange.send()
                    }, label: {
                        Text("Stay")
                    })}
                    .offset(x: 10, y: 0)}
        }
    }
}

func multiply(index: Int, offset: Int) -> CGFloat {
    return CGFloat(index*offset)
}

#if DEBUG
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView.init(player: player)
    }}
#endif


var player = Player.init(id: "Player1", hands: [setUpHandView()], game: GameViewModel.init(), isRobot: false)
