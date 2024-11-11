//
//  DogView.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 2/2/21.
//

import SwiftUI
import Vision

struct DogView: View {
    @State var activeCover: ActiveCover?
    @State var inputImage: UIImage?
    @State var oldImage: UIImage?
    @State var currentPage = 1
    @State var dogResultsLogic = DogResultsLogic(clearWinner: nil, tiedWinners: nil, otherPossibilities: nil)
    @State var showToast = false
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Which dog breed?")
                        .font(.system(size: 34, weight: .medium))
                    
                    Spacer()
                }
                .padding(.leading, 20)
                
                ZStack {
                    DogPickerView(activeCover: $activeCover)
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
                    DogResultsView(image: .constant(Image(uiImage: inputImage ?? UIImage(named: "imagePickerDog")!)), resultsLogic: $dogResultsLogic)
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
                .offset(y: 50)
                .offset(y: (UIDevice.current.hasNotch || oldImage == nil) ? 0 : -30)
                
                Spacer()
                
                PageControl(color: Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), currentPage: $currentPage)
                    .frame(width: 55, height: 30)
                    .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .clipShape(Capsule())
                    .shadow(radius: 10, x: 0, y: 10)
                    .isHidden(inputImage == nil, remove: true)
                    .offset(y: UIDevice.current.hasNotch ? 0 : -30)

                Spacer()
            }
            .padding(.top, 44)
            .toast(isPresenting: $showToast) {
                AlertToast(type: .image("noDog", Color.gray),
                           title: "No dog found")
            }
            .fullScreenCover(item: $activeCover, onDismiss: loadImage) { item in
                switch item {
                case .camera:
                    CameraPicker(image: $inputImage, allowsEditing: true)
                case .photoLibrary:
                    PhotoPicker(image: $inputImage, allowsEditing: true)
                }
            }
        }
        
    }
    
    func loadImage() {
        guard let inputImage = inputImage, inputImage != oldImage else {
            print("failed input image")
            return
        }
        
        var animalRecognitionRequest = VNRecognizeAnimalsRequest(completionHandler: nil)
        
        let animalRecognitionWorkQueue = DispatchQueue(label: "PetClassifierRequest", qos: .userInteractive, attributes: [], autoreleaseFrequency: .workItem)
        
        guard let cgImage = inputImage.cgImage else {
            return
        }
        
        animalRecognitionWorkQueue.async {
            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            do {
                try requestHandler.perform([animalRecognitionRequest])
            }
            catch {}
        }
        
        animalRecognitionRequest = VNRecognizeAnimalsRequest { request, error in
            if let results = request.results as? [VNRecognizedObjectObservation] {
                if results.contains(where: { result in
                    let animals = result.labels
                    
                    return animals.contains { object in
                        object.identifier == "Dog"
                    }
                }) {
                    //there is a dog
                    DogDetector.shared.detectImageContent(image: inputImage) { [self] resultsAndProbabilites in
                        dogResultsLogic = DogResultsInterpreter.shared.determineProbabilities(results: resultsAndProbabilites)
                    }
                    oldImage = inputImage
                    currentPage = 0
                }
                else {
                    //there is not dog
                    showToast.toggle()
                    self.inputImage = nil
                    self.oldImage = nil
                }
            }
        }
    }
}

enum ActiveCover: Identifiable {
    case camera, photoLibrary
    
    var id: Int {
        hashValue
    }
}

struct DogView_Previews: PreviewProvider {
    static var previews: some View {
        DogView()
    }
}
