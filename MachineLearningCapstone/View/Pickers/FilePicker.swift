//
//  MediaPickers.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 1/17/21.
//

import SwiftUI
import UniformTypeIdentifiers
import CoreServices

struct FilePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate {
        
        var parent: FilePicker
        
        init (_ parent: FilePicker) {
            print("inited")
            self.parent = parent
        }
        
        public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else {
                return
            }
            
            let image = UIImage(contentsOfFile: url.path)
            parent.image = image!
            parent.presentaionMode.wrappedValue.dismiss()
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            print("cancelled")
        }
    }
    
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentaionMode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<FilePicker>) -> UIDocumentPickerViewController {
        let pickerViewController = UIDocumentPickerViewController(forOpeningContentTypes: [.image, .jpeg, .png, .pdf], asCopy: true)
        pickerViewController.delegate = context.coordinator
        return pickerViewController
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<FilePicker>) {
    }
}
