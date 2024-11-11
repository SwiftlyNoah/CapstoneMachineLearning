//
//  PhotoLibraryView.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 2/6/21.
//

//import SwiftUI
//
//struct PhotoLibraryView: View {
//    @StateObject var photoLibraryViewModel = PhotoLibraryViewModel()
//    @Binding var inputImage: UIImage?
//    @Environment(\.presentationMode) var presentaionMode
//    
//    var body: some View {
//        
//        NavigationView {
//            ZStack {
//                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))]), startPoint: .top, endPoint: .bottom)
//                    .edgesIgnoringSafeArea(.all)
//                
//                ScrollView {
//                    // Compositional Layout....
//                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3)) {
//                        ForEach(0..<photoLibraryViewModel.uiImages.count, id: \.self) { index in
//                            Image(uiImage: photoLibraryViewModel.uiImages[index])
//                                .resizable()
//                                .frame(width: (screen.width - 60) / 3, height: (screen.width - 60) / 3)
//                                .cornerRadius(13)
//                                .onTapGesture {
//                                    inputImage = photoLibraryViewModel.uiImages[index]
//                                    presentaionMode.wrappedValue.dismiss()
//                                }
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//            }
//            .navigationTitle("Dog images")
//        }
//    }
//}
