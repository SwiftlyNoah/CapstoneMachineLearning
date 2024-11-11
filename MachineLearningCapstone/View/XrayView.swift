//
//  XrayView.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 1/17/21.
//

import SwiftUI

struct XrayView: View {
    @State private var image: Image?
    @State private var activeSheet: ActiveSheet?
    @State private var inputImage: UIImage?
    @State private var oldImage: UIImage?
    @State private var chance = 0
    @State private var showToast = false
    @State private var isFromDemo = true
    @State private var currentPage = 1
    @AppStorage("showAlert") var showAlert: Bool = true
    
    let demoTappedPub = NotificationCenter.default
        .publisher(for: NSNotification.Name("DemoImageTapped"))
    
    var body: some View {
        ZStack {
            
            Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Pneumonia or Not?")
                        .font(.system(size: 34, weight: .medium))
                    
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.top, UIDevice.current.hasNotch ? 44 : 20)
                
                ZStack {
                    XrayPickerView(activeSheet: $activeSheet)
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .frame(width: screen.width-100, height: screen.height/2)
                        .shadow(radius: 20, x: 0, y: 20)
                        .offset(x: currentPage == 1 ? 0 : 400)
                        .animation(.easeInOut(duration: 1))
                        .modifier(
                            SwipeGestureModifier(toTheRight: false) {
                                if inputImage != nil {
                                    currentPage = 0
                                }
                            }
                        )
                    
                    XrayResultsView(image: .constant(Image(uiImage: inputImage ?? UIImage(named: "imagePickerXray")!)), chance: $chance)
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .frame(width: screen.width-100, height: screen.height/2)
                        .offset(x: currentPage == 1 ? -400 : 0)
                        .shadow(radius: 20, x: 0, y: 20)
                        .animation(.easeInOut(duration: 1))
                        .modifier(
                            SwipeGestureModifier(toTheRight: true) {
                                currentPage = 1
                            }
                        )
                }
                .offset(y: (UIDevice.current.hasNotch || oldImage == nil) ? 0 : -30)
                .offset(y: 50)
                
                Spacer()
                
                PageControl(color: Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)), currentPage: $currentPage)
                    .frame(width: 55, height: 30)
                    .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .clipShape(Capsule())
                    .shadow(radius: 10, x: 0, y: 10)
                    .isHidden(inputImage == nil)
                    .offset(y: (UIDevice.current.hasNotch || oldImage == nil) ? 0 : -30)

                Spacer()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Important Note"), message: Text("While this pneumonia detector is cool, please do not trust it for actual medical advice"), dismissButton: .default(Text("Got it!")))
        }
        .sheet(item: $activeSheet, onDismiss: loadImage) { item in
            switch item {
            case .photo:
                PhotoPicker(image: $inputImage)
            case .demo:
                DemoPicker()
            }
        }
        .onReceive(demoTappedPub) { output in
            getImageName(output)
        }
        .toast(isPresenting: $showToast) {
            AlertToast(type: .image("noXray", Color.gray),
                       title: "No x-ray found")
            
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage, inputImage != oldImage else {
            return
        }
        
        inputImage.colorPixels { pixels in
            if pixels > 15 {
                showToast.toggle()
                self.inputImage = nil
                self.oldImage = nil
            }
            else {
                PnuemoniaDetector.shared.detectImageContent(image: inputImage) { int in
                    chance = int
                }
                oldImage = inputImage
                image = Image(uiImage: inputImage)
                currentPage = 0
            }
        }
    }
    
    func getImageName(_ notification: Notification) {
        let imageName = notification.userInfo?["imageName"] as! String
        inputImage = UIImage(named: imageName)
    }
}

enum ActiveSheet: Identifiable {
    case photo, demo
    
    var id: Int {
        hashValue
    }
}

let screen = UIScreen.main.bounds
