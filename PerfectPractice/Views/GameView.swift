//
//  GameView.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-30.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var game:GameViewModel
    var body: some View {
        ZStack{Rectangle().foregroundColor(Color.init(red: 0.21, green: 0.40, blue: 0.30, opacity: 1.00)).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                HandView.init(hand: self.game.dealer).offset(x: 0, y: 0)
                HStack {PlayerView.init(player: self.game.players[0]).padding(.all).rotationEffect(Angle.init(degrees: 90)).scaledToFit().scaleEffect(0.7)
                    Spacer().frame(minWidth: 10, maxWidth: (.infinity))
                    PlayerView.init(player: self.game.players[2]).padding(.all).rotationEffect(Angle.init(degrees: -90)).scaledToFit().scaleEffect(0.7)
                }
                PlayerView.init(player: self.game.players[1]).padding(.all)
                    .animation(.easeInOut(duration: 2))
                HStack(spacing: 0)
                { Button(action: {
                    self.game.resetGame()
                }, label: {
                        Text("Reset")
                    }).offset(x: -8, y: 0)}.padding(.leading, -100)
                    
            }.animation(.easeInOut(duration: 3))
            
        }

    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(setUpGame())
    }
}
