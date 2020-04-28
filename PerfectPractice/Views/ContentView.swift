//
//  ContentView.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-22.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var game:Game
    @State var gameIsStarted:Bool = true

    var body: some View {
        ZStack{
           if gameIsStarted { Rectangle().foregroundColor(Color.init(red: 0.21, green: 0.40, blue: 0.30, opacity: 1.00)).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
//                PlayerView().environmentObject((self.game.dealer)).offset(x: 0, y: 30)
                Spacer()
                HStack {PlayerView().environmentObject(self.game.players[3]).padding(.all).rotationEffect(Angle.init(degrees: 90)).scaledToFit().scaleEffect(0.7)
                    Spacer().frame(minWidth: 10, maxWidth: (.infinity))
                    PlayerView().environmentObject(self.game.players[2]).padding(.all).rotationEffect(Angle.init(degrees: -90)).scaledToFit().scaleEffect(0.7)
                }
                
                PlayerView().environmentObject(self.game.players[3]).padding(.all)

            }

           } else {
            Button(action: {
                DispatchQueue.main.async {
                 self.game.startGame()
                }
                self.gameIsStarted = true
            }, label: {
                Text("Start")
            })
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(setUpGame())
    }
}



func setUpGame()-> Game {
    let game = Game.init()

    var players = [Player(id: "Rohan", hands: nil,game: game, isRobot: false ), Player(id: "Rajesh", hands: nil,game: game, isRobot: false ), Player(id: "Geeta", hands: nil,game: game, isRobot: false ), Player(id: "Ria", hands: nil,game: game, isRobot: false )]
    game.startGame()
    return game
}
