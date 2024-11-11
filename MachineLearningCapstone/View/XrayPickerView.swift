//
//  PickerView.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 1/18/21.
//

import SwiftUI

struct XrayPickerView: View {
    @Binding var activeSheet: ActiveSheet?
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color(#colorLiteral(red: 0.6822845936, green: 0.6824014783, blue: 0.6994705796, alpha: 1))
                
                Image("imagePickerXray")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .opacity(0.2)
                    .clipped()
                
                Text("Upload an image \nof your own!")
                    .fontWeight(.semibold)
                    .font(.title3)
                    .multilineTextAlignment(.center)
            }
            .frame(width: screen.width-100, height: screen.height/2-155)
            
            
            VStack(alignment: .center, spacing: 25) {
                Text("How would you like to import an x-ray?")
                    .font(.system(size: 20)).multilineTextAlignment(.center)
                    .lineLimit(3)
                    .frame(height: 50)
                    .padding(.top)
                
                HStack {
                    Button(action: {
                        //Camera
                        activeSheet = .photo
                    }) {
                        Text("Photos")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.black)
                    }
                    .frame(width: 120, height: 40)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    
                    Spacer()
                    
                    Button(action: {
                        //Photo Library
                        activeSheet = .demo
                    }) {
                        Text("Demo Image")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.black)
                    }
                    .frame(width: 120, height: 40)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)), Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))]), startPoint: .top, endPoint: .bottom))
            .frame(width: screen.width-100)
        }

    }
}

struct XrayPickerView_Previews: PreviewProvider {
    static var previews: some View {
        XrayPickerView(activeSheet: .constant(nil))
    }
}
