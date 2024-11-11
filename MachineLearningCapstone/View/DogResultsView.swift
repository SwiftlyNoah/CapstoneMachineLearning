//
//  DogResultsView.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 2/9/21.
//

import SwiftUI

struct DogResultsView: View {
    @Binding var image: Image?
    @Binding var resultsLogic: DogResultsLogic
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: screen.width-100, height: screen.height/2-155)
                .clipped()
            
            VStack(spacing: 15) {
                Text("Your dog is a...")
                    .fontWeight(.semibold)
                    .isHidden((resultsLogic.clearWinner == nil && resultsLogic.tiedWinners == nil), remove: true)
                
                Text(
                    resultsLogic.clearWinner != nil ? "\(resultsLogic.clearWinner!.breed) - \(resultsLogic.clearWinner!.probability)% chance" : ""
                )
                .isHidden(resultsLogic.clearWinner == nil, remove: true)


                VStack(spacing: 10) {
                    Text(resultsLogic.tiedWinners != nil ? "\(resultsLogic.tiedWinners![0].breed) - \(resultsLogic.tiedWinners![0].probability)% chance" : "")
                    
                    Text(resultsLogic.tiedWinners != nil ? "or a" : "")
                        .fontWeight(.semibold)
                    
                    Text(resultsLogic.tiedWinners != nil ? "\(resultsLogic.tiedWinners![1].breed) - \(resultsLogic.tiedWinners![1].probability)% chance" : "")
                }
                .isHidden(resultsLogic.tiedWinners == nil, remove: true)
                
                
                Text(!(resultsLogic.tiedWinners == nil && resultsLogic.clearWinner == nil) ? "But could also be a..." : "Your dog could be a...")
                    .fontWeight(.semibold)
                    .isHidden(resultsLogic.otherPossibilities == nil, remove: true)
                
                VStack(spacing: 10) {
                    Text(generateText(index: 0) == nil ? "" : generateText(index: 0)!)
                        .isHidden(generateText(index: 0) == nil, remove: true)
                    
                    Text(generateText(index: 1) == nil ? "" : generateText(index: 1)!)
                        .isHidden(generateText(index: 1) == nil, remove: true)
                    
                    Text(generateText(index: 2) == nil ? "" : generateText(index: 2)!)
                        .isHidden(generateText(index: 2) == nil, remove: true)
                }
                .isHidden(resultsLogic.otherPossibilities == nil, remove: true)
            }
            .padding(.bottom)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
    }
    
    private func generateText(index: Int) -> String? {
        guard resultsLogic.otherPossibilities?.count ?? 0 > index else {
            return nil
        }
        var breed = resultsLogic.otherPossibilities![index].breed
        if breed.count > 20 {
            breed.removeLast(breed.count-20)
            breed.removeLast(3)
            if breed.last == " " {
                breed.removeLast()
            }
            breed.append("...")
        }
        return "\(breed) - \(resultsLogic.otherPossibilities![index].probability)% chance"
    }
}
