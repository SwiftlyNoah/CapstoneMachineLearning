//
//  PhotoLibraryViewModel.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 2/6/21.
//

//import Photos
//import UIKit
//import Vision
//
//class PhotoLibraryViewModel: ObservableObject {
//    
//    @Published var uiImages = [UIImage]()
//    var allPhotos : PHFetchResult<PHAsset>? = nil
//        
//    init() {
//        getPhotos()
//    }
//    
//    private func getPhotos() {
//        PHPhotoLibrary.requestAuthorization { [weak self] status in
//            switch status {
//            case .authorized:
//                let fetchOptions = PHFetchOptions()
//                fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
//                self?.allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
//                self?.setCompositionalLayout()
//            case .denied, .restricted:
//                print("Not allowed")
//            case .notDetermined:
//                print("Not determined yet")
//            case .limited:
//                print("limited")
//            @unknown default:
//                fatalError()
//            }
//        }
//    }
//    
//    private func setCompositionalLayout() {
//        print("all photos: " + "\(allPhotos!.count)")
//        
//        allPhotos?.enumerateObjects() { [self] photo, _, _  in
//            
//            let options = PHImageRequestOptions()
//            options.version = .original
//            
//            PHImageManager.default().requestImage(for: photo, targetSize: CGSize(width: (screen.width - 60) / 3, height: (screen.width - 60) / 3), contentMode: PHImageContentMode.aspectFit, options: options) { [self] uiImage, _ in
//                
//                guard let finalUIImage = uiImage else {
//                    print("failed to make finalUIImage")
//                    return
//                }
//                
//                checkImage(uiImage: finalUIImage)
//
//            }
//        }
//    }
//    
//    private func checkImage(uiImage: UIImage) {
//        
//        var animalRecognitionRequest = VNRecognizeAnimalsRequest(completionHandler: nil)
//        
//        let animalRecognitionWorkQueue = DispatchQueue(label: "PetClassifierRequest", qos: .userInteractive, attributes: [], autoreleaseFrequency: .workItem)
//        
//        guard let cgImage = uiImage.cgImage else {
//            print("failed to convert image")
//            return
//        }
//        
//        animalRecognitionWorkQueue.async {
//            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
//            do {
//                try requestHandler.perform([animalRecognitionRequest])
//            } catch {
//                print("error: " + "\(error)")
//            }
//        }
//        
//        animalRecognitionRequest = VNRecognizeAnimalsRequest { [self] request, error in
//            if let results = request.results as? [VNRecognizedObjectObservation] {
//                if results.contains(where: { result in
//                    let animals = result.labels
//                    
//                    return animals.contains(where: { object in
//                        object.identifier == "Dog"
//                    })
//                })
//                {
//                    DispatchQueue.main.async {
//                        uiImages.append(uiImage)
//                        print("dog detected'")
//                    }
//                }
//            }
//        }
//    }
//}
