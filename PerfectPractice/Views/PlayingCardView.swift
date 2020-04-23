//
//  PlayingCardView.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-23.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import SwiftUI

struct PlayingCardView: View {
    var body: some View {
        ZStack{
            Rectangle().frame(width: 130, height:182).foregroundColor(Color.init(#colorLiteral(red: 0.9999127984, green: 1, blue: 0.9998814464, alpha: 1))).cornerRadius(25).overlay(Image("HeartsSuit").resizable().aspectRatio(contentMode: .fit).padding(.all))
            Text("2").font(.custom("Poppins-SemiBoldItalic", size: 40)).offset(x: 29, y: -70)
            Text("2").font(.custom("Poppins-SemiBoldItalic", size: 40)).offset(x: 29, y: -70).rotationEffect(Angle.init(degrees: 180))
        }.clipShape(RoundedRectangle(cornerRadius: 25)).overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 2))
    }
}


struct PlayingCardView_Previews: PreviewProvider {
    static var previews: some View {
        PlayingCardView()
    }
}
