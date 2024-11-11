//
//  Home.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 1/29/21.
//

import SwiftUI

struct Home: View {
    @Binding var show: Bool
    @State var selectedtab = "home"
    
    @State var orange = true
    
    // Location For each Curve...
    @State var xAxis: CGFloat = 0
    @Namespace var animation
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedtab) {
                HomeView(show: $show)
                    .tag("home")
                
                XrayView()
                    .tag("x-ray")
                
                DogView()
                    .tag("dog")
                
                LearnView()
                    .tag("book")
                    
            }
            
            // Custom tab Bar...
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { image in
                    GeometryReader { reader in
                        Button(action: {
                            withAnimation(.spring()) {
                                selectedtab = image
                                xAxis = reader.frame(in: .global).minX
                            }
                        }) {
                            Image(image)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(selectedtab == image ? getColor(image: image) : Color.gray)
                                .padding(selectedtab == image ? 15 : 0)
                                .background(Color.white.opacity(selectedtab == image ? 1 : 0).clipShape(Circle()))
                                .matchedGeometryEffect(id: image, in: animation)
                                .offset(x: selectedtab == image ? (reader.frame(in: .global).minX - reader.frame(in: .global).midX) : 0, y: selectedtab == image ? -50 : 0)
                            
                        }
                        .onAppear {
                            if image == tabs.first {
                                xAxis = reader.frame(in: .global).minX
                            }
                        }
                    }
                    .frame(width: 25, height: 30)
                    
                    if image != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical)
            .background(Color.white.clipShape(CustomShape(xAxis: xAxis)).cornerRadius(12))
            .padding(.horizontal)
            // Bottom Edge...
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .padding(.bottom, !UIDevice.current.hasNotch ? 16 : 0)
            .shadow(radius: 30, x: 0, y: 20)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    // getting Image Color....
    func getColor(image: String) -> Color {
        
        switch image {
        case "home":
            return Color("color1")
        case "x-ray":
            return Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))
        case "dog":
            return Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
        default:
            return Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
        }
    }
}
