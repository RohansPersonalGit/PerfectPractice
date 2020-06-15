//
//  PlayingCardView.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-23.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import SwiftUI

struct PlayingCardView: View {
     var rank: Int
     var suit: Suit
     var isFaceUp: Bool
    @State var opacityCard = 0.0
    var body: some View {
        ZStack{
            if isFaceUp {
                Rectangle().frame(width: 130, height:182).foregroundColor(Color.init(#colorLiteral(red: 0.9999127984, green: 1, blue: 0.9998814464, alpha: 1))).cornerRadius(25).overlay(Image(self.suit.rawValue).resizable().aspectRatio(contentMode: .fit).padding(.all))
                Text(String(self.rank)).font(.custom("Poppins-SemiBoldItalic", size: 40)).offset(x: 29, y: -70)
                Text(String(self.rank)).font(.custom("Poppins-SemiBoldItalic", size: 40)).offset(x: 29, y: -70).rotationEffect(Angle.init(degrees: 180))
            }
            else {
                Rectangle().frame(width: 130, height:182).foregroundColor(Color.init(UIColor(red: 0.58, green: 0.65, blue: 0.65, alpha: 1.00)
                )).cornerRadius(25)
            }
        }.clipShape(RoundedRectangle(cornerRadius: 25)).overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 2))
        
    }
}

#if DEBUG
struct PlayingCardView_Previews: PreviewProvider {
    static var previews: some View {
        PlayingCardView(rank: Rank.ace.rawValue, suit: Suit.spade, isFaceUp: true)
    }
}
#endif

struct testView: View {
    @State var opacityCircle1 = 0.0
    @State var opacityCircle2 = 0.0

    var body: some View {
        VStack {
            Circle()
                .opacity(opacityCircle1)
                .animate(using: Animation.easeInOut(duration: 2).delay(3)) { self.opacityCircle1 = 1.0 }
            PlayerView(player: player)
                .opacity(opacityCircle2)
                .animate(using: Animation.easeInOut(duration: 2).delay(1)) { self.opacityCircle2 = 1.0 }
        }
    }
}
extension View {
    func animate(using animation: Animation, _ action: @escaping () -> Void) -> some View {
        return onAppear {
            withAnimation(animation) {
                action()
            }
        }
    }
}
