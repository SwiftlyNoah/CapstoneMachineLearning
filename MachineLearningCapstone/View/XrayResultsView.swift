//
//  XrayResultsView.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 3/4/21.
//

import SwiftUI

struct XrayResultsView: View {
    @Binding var image: Image?
    @Binding var chance: Int
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: screen.width-100, height: screen.height/2-155)
                .clipped()
            
            VStack(spacing: 15) {
                Text(chance < 10 ? "That's Good!": chance < 60  ? "Not looking great" : "Oh No!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                Text("You have a \(chance)% chance \nof pneumonia")
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            .padding(.bottom)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)), Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))]), startPoint: .top, endPoint: .bottom))
    }
}
