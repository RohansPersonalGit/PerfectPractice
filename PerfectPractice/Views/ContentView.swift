//
//  ContentView.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-22.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var game:GameViewModel
    @State var gameIsStarted:Bool = false

    var body: some View {
        ZStack{
            Button(action: {
                if(!self.gameIsStarted){
                    //We need to reposition this 
                    self.gameIsStarted.toggle()
                }
                
            })
            {
                Text("Start")
            }
            if self.gameIsStarted {
                Group{GameView.init().environmentObject(self.game)}
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(setUpGame())
    }
}



func setUpGame()-> GameViewModel {
    let game = GameViewModel.init()

    _ = [Player(id: "Rohan", hands: nil,game: game, isRobot: true ), Player(id: "Rajesh", hands: nil,game: game, isRobot: false ), Player(id: "Geeta", hands: nil,game: game, isRobot: true ), Player(id: "Ria", hands: nil,game: game, isRobot: true )]
    game.startGame()
    return game
}
