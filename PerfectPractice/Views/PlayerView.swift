//
//  PlayerView.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-23.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import SwiftUI

struct PlayerView: View {
    //changing this to state causes issues 
    @ObservedObject var player:Player
    var bust: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: CGPoint.init(x: geometry.frame(in: .local).midX, y: CGFloat(geometry.frame(in: .local).midY)/2))
                path.addLine(to: CGPoint.init(x: geometry.frame(in: .local).minX, y: geometry.frame(in: .local).minY))
                path.move(to: CGPoint.init(x: geometry.frame(in: .local).midX, y: CGFloat(geometry.frame(in: .local).midY)/2))
                path.addLine(to: CGPoint.init(x: geometry.frame(in: .local).minX, y: (geometry.frame(in: .local).minY) + 180))
                path.move(to: CGPoint.init(x: geometry.frame(in: .local).midX, y: CGFloat(geometry.frame(in: .local).midY)/2))
                path.addLine(to: CGPoint.init(x: geometry.frame(in: .local).maxX, y: (geometry.frame(in: .local).minY) + 180))
                path.move(to: CGPoint.init(x: geometry.frame(in: .local).midX, y: CGFloat(geometry.frame(in: .local).midY)/2))
                path.addLine(to: CGPoint.init(x: geometry.frame(in: .local).maxX, y: geometry.frame(in: .local).minY))
            }
            .stroke(Color.red,lineWidth: 10)
            
        }
    }
    var body: some View {
        HStack {
            ZStack {
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
                if self.player.isBust{
                    self.bust
                }
            }
            if !player.isRobot{
                VStack{Button(action: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        self.player.requestCard()
                    }
                }, label: {
                    Text("Hit Me!")
                })
                Button(action: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        self.player.stay()
                    }
                }, label: {
                    Text("Stay!")
                })
            }
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
