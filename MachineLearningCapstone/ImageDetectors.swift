//
//  PneumoniaDetector.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 1/29/21.
//

import Vision
import CoreML
import UIKit
import SwiftUI

class PnuemoniaDetector {
    
    static let shared = PnuemoniaDetector()
    
    private init() {}
    
    func detectImageContent(image: UIImage, completion: @escaping (Int) -> Void) {
        
        guard let ciImage = CIImage(image: image) else {
            completion(0)
            return
        }
        
        guard let model = try? VNCoreMLModel(for: Pneumonia().model) else {
            completion(0)
            return
        }
        
        //Create a vision request
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation],
                  let topResult = results.first
            else {
                return
            }
            
            var chance = 0
            
            if topResult.identifier == "PNEUMONIA" {
                chance = Int(topResult.confidence * 100)
            }
            else {
                chance = 100 - Int(topResult.confidence * 100)
            }
            
            completion(chance)
        }
        
        //Run the CarOrDog classifier
        let handler = VNImageRequestHandler(ciImage: ciImage)
        DispatchQueue.global().async {
            do {
                try handler.perform([request])
            } catch {
                print("Error")
            }
        }
    }
}

class DogDetector {
    
    static let shared = DogDetector()
    
    private init() {}
    
    func detectImageContent(image: UIImage, completion: @escaping ([DogResult]) -> Void) {
        
        guard let ciImage = CIImage(image: image) else {
            return
        }
        
        guard let model = try? VNCoreMLModel(for: DogBreed().model) else {
            return
        }
        
        //Create a vision request
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                return
            }
            
            var breedsAndPercentages = [DogResult]()
            
            for result in results {
                if result.confidence * 100 >= 5 {
                    breedsAndPercentages.append(DogResult(breed: result.identifier.replacingOccurrences(of: "_", with: " "), probability: Int(result.confidence * 100)))
                }
            }
            completion(breedsAndPercentages)

            
        }
        
        //Run the CarOrDog classifier
        let handler = VNImageRequestHandler(ciImage: ciImage)
        DispatchQueue.global().async {
            do {
                try handler.perform([request])
            } catch {
                print("Error")
            }
        }
    }
}
