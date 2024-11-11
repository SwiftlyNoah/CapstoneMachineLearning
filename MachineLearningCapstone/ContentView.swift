//
//  ContentView.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 1/16/21.
//

import SwiftUI

struct ContentView: View {
    @State var animate = false
    @State var endSplash = false
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            Home(show: $endSplash)
            
            ZStack {
                Color.black
                
                Image("capstoneLarge")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: animate ? .fill : .fit)
                    .frame(width: animate ? nil : 85, height: animate ? nil : 85)
                    .offset(x: animate ? -125 : 0, y: -50)
                    .scaleEffect(animate ? 4 : 1)
                    .frame(width: screen.width)
                
            }
            .ignoresSafeArea(.all, edges: .all)
            .onAppear(perform: animateSplash)
            .opacity(endSplash ? 0 : 1)
        }
    }
    
    func animateSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation(Animation.easeOut(duration: 1)) {
                animate.toggle()
            }
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.35) {
            endSplash.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


var tabs = ["home","x-ray","dog","book"]

