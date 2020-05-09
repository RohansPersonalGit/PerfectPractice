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
                HandView.init().environmentObject(self.game.dealer)
                Spacer()
                HStack {PlayerView().environmentObject(self.game.players[3]).padding(.all).rotationEffect(Angle.init(degrees: 90)).scaledToFit().scaleEffect(0.7)
                    Spacer().frame(minWidth: 10, maxWidth: (.infinity))
                    PlayerView().environmentObject(self.game.players[2]).padding(.all).rotationEffect(Angle.init(degrees: -90)).scaledToFit().scaleEffect(0.7)
                }
                
                PlayerView().environmentObject(self.game.players[1]).padding(.all)
                
            }
            .animation(.easeInOut(duration: 2))
        }
        .onAppear{
           self.game.startGame()
        }
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(setUpGame())
    }
}
