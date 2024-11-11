//
//  CommentedCode.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 3/4/21.
//

import Foundation

//MARK: - Linear Gradient from old XrayView


//            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)), Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))]), startPoint: .top, endPoint: .bottom)
//


//MARK: - Result from old XrayView

//                Text("\(result)")
//                    .fontWeight(.medium)
//                    .padding(.top, 50)
//                    .font(.title)
//                    .frame(height: 100)
//                    .opacity(image == nil ? 0 : 1)

//MARK: - ViewModifier from old XrayView

//            .padding(.top, 44)
//            .frame(width: screen.width)
//            .background(Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)))
//            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
//            .shadow(radius: 20, x: 0, y: 20)
//            .offset(y: showMenu ? -500 : 0)
//            .rotation3DEffect(Angle(degrees: showMenu ? Double(viewState.height / 20) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
//            .scaleEffect(showMenu ? 0.9 : 1)
//            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
//            .edgesIgnoringSafeArea(.all)
//            .onTapGesture {
//                showMenu = false
//            }

//MARK: - XrayMenuView from old XrayView


//            XrayMenuView(activeSheet: $activeSheet)
//                .background(Color.black.opacity(0.001))
//                .offset(y: showMenu ? (UIDevice.current.hasNotch ? 130 : 50) : screen.height)
//                .offset(y: viewState.height)
//                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
//                .onTapGesture {
//                    self.showMenu.toggle()
//                }
//                .gesture(
//                    DragGesture().onChanged { value in
//                        self.viewState = value.translation
//                    }
//                    .onEnded { value in
//                        if self.viewState.height > 50 {
//                            self.showMenu = false
//                        }
//                        self.viewState = .zero
//                    }
//                )

//MARK: - Old XrayPickerView.swift

//import SwiftUI
//
//struct XrayPickerView: View {
//    @Binding var image: Image?
//
//    var body: some View {
//        ZStack {
//            Color(#colorLiteral(red: 0.6822845936, green: 0.6824014783, blue: 0.6994705796, alpha: 1))
//
//            Image("imagePickerXray")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .opacity(0.2)
//                .frame(width: screen.width-100, height: screen.height/2)
//                .clipped()
//                .opacity(image == nil ? 1 : 0)
//
//            image?
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: screen.width-100, height: screen.height/2)
//                .opacity(0.4)
//                .clipped()
//
//            Text(image == nil ? "Tap here to upload a chest \n x-ray or use a provided one" : "Tap here to upload another \n chest x-ray or use \n a provided one")
//                .fontWeight(.semibold)
//                .font(.title3)
//                .multilineTextAlignment(.center)
//
//        }
//    }
//
//}

//MARK: - Old XrayMenuView.swift


//import SwiftUI
//
//struct XrayMenuView: View {
//    @Binding var activeSheet: ActiveSheet?
//
//    var body: some View {
//        VStack(alignment: .center, spacing: 20) {
//            Text("Upload an x-ray of your own")
//                .font(.system(size: 20))
//            HStack {
//                Button(action: {
//                    self.activeSheet = .photo
//                }) {
//                    Text("Photo Library")
//                        .font(.system(size: 20, weight: .light))
//                        .foregroundColor(Color.black)
//                }
//                .frame(width: 150, height: 40)
//                .background(Color.white)
//                .clipShape(RoundedRectangle(cornerRadius: 6))
//
//                Button(action: {
//                    self.activeSheet = .file
//                }) {
//                    Text("Files")
//                        .font(.system(size: 20, weight: .light))
//                        .foregroundColor(Color.black)
//                }
//                .frame(width: 150, height: 40)
//                .background(Color.white)
//                .clipShape(RoundedRectangle(cornerRadius: 6))
//            }
//            Text("Or use a provided image")
//                .font(.system(size: 20))
//            Button(action: {
//                self.activeSheet = .demo
//            }) {
//                Text("Demo image")
//                    .font(.system(size: 20, weight: .light))
//                    .foregroundColor(Color.black)
//            }
//            .frame(width: 150, height: 40)
//            .background(Color.white)
//            .clipShape(RoundedRectangle(cornerRadius: 6))
//        }
//        .frame(maxWidth: .infinity)
//        .frame(height: 300)
//        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)), Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))]), startPoint: .top, endPoint: .bottom))
//        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
//        .shadow(radius: 20, x: 0, y: 20)
//        .padding(.horizontal, 30)
//        .padding(.bottom, 30)
//    }
//}
