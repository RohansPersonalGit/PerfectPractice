//
//  GameView.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-30.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var game:GameViewModel
    @State var handOpac = 0.0
    @State var gameOpac = 0.0
    @State var player1Opac = 0.0
    @State var player2Opac = 0.0
    @State var player3Opac = 0.0
    var body: some View {
        ZStack{
            Rectangle().foregroundColor(Color.init(red: 0.21, green: 0.40, blue: 0.30, opacity: 1.00)).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                HandView.init(hand: game.dealer).offset(x: 0, y: 0).opacity(self.handOpac).animate(using: Animation.easeInOut(duration: 0.5).delay(8)) {self.handOpac=1.0}
                
                HStack {PlayerView.init(player: self.game.players[0]).opacity(self.player1Opac).padding(.all).rotationEffect(Angle.init(degrees: 90)).scaledToFit().scaleEffect(0.7).animate(using: Animation.easeInOut(duration: 0.5).delay(2)) {self.player1Opac =  1.0}
                    Spacer().frame(minWidth: 10)
                    PlayerView.init(player: self.game.players[2]).opacity(self.player3Opac).padding(.all).rotationEffect(Angle.init(degrees: -90)).scaledToFit().scaleEffect(0.7).animate(using: Animation.easeInOut(duration: 0.5).delay(6)){self.player3Opac = 1.0}
                }
                PlayerView.init(player: self.game.players[1]).opacity(self.player2Opac).padding(.all).animate(using: Animation.easeInOut(duration: 0.5).delay(4)){self.player2Opac=1.0}
                HStack(spacing: 0)
                { Button(action: {
                    self.game.resetGame()
                }, label: {
                    Text("Reset")
                }).offset(x: -8, y: 0)}.padding(.leading, -100)
                
            }.opacity(self.gameOpac).animate(using: Animation.easeInOut(duration: 1.2).delay(1)){
                self.gameOpac = 1
            }
        }
        
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: setUpGame())
    }
}

