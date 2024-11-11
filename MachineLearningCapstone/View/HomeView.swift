//
//  HomeView.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 2/1/21.
//

import SwiftUI

struct HomeView: View {
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            Color("color1")
                .edgesIgnoringSafeArea(.all)
                .zIndex(0)
            
            VStack {
                if show {
                    Text("Machine Learning in Medicine")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .animation(.easeOut(duration: 1))
                        .transition(.move(edge: .trailing))
                        .padding(.bottom, 20)
                    
                    Text("By: Noah Brauner")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.bottom, 20)
                        .animation(.easeOut(duration: 1))
                        .transition(.move(edge: .leading))
                    
                    Text("This app has two examples of real world uses of machine learning: a machine learning model that can diagnose pneumonia and a dog breed detector! See if the app can correctly guess your dog's breed by airdropping a pic to the computer and uploading it in the app!")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .zIndex(1)
                        .animation(.easeOut(duration: 1))
                        .transition(.move(edge: .leading))
                }
                
                Spacer()
            }
            .padding(.horizontal, 10)
        }
    }
}
