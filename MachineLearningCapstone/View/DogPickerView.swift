//
//  DogPickerView.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 2/2/21.
//

import SwiftUI

struct DogPickerView: View {
    @Binding var activeCover: ActiveCover?
    
    var body: some View {
        VStack(spacing: 0) {
            Image("imagePickerDog")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: screen.width-100, height: screen.height/2-155)
                .clipped()
            
            VStack(alignment: .center, spacing: 25) {
                Text("How would you like to import a dog pic?")
                    .font(.system(size: 20)).multilineTextAlignment(.center)
                    .lineLimit(3)
                    .frame(height: 50)
                    .padding(.top)
                
                HStack {
                    Button(action: {
                        //Camera
                        activeCover = .camera
                    }) {
                        Text("Camera")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.black)
                    }
                    .frame(width: 110, height: 40)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    
                    Spacer()
                    
                    Button(action: {
                        //Photo Library
                        activeCover = .photoLibrary
                    }) {
                        Text("Photos")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.black)
                    }
                    .frame(width: 110, height: 40)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
            .frame(width: screen.width-100)
        }

    }
}
