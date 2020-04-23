//
//  ContentView.swift
//  PerfectPractice
//
//  Created by Rohan Garg on 2020-04-22.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Rectangle().foregroundColor(Color.init(red: 0.21, green: 0.40, blue: 0.30, opacity: 1.00)).edgesIgnoringSafeArea(.all)
            PlayingCardView().overlay(PlayingCardView().offset(x: 15, y: 40))
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

 


