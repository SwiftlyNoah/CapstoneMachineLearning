//
//  Extensions.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 2/2/21.
//

import SwiftUI

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}

extension View {
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    /// ```
    /// Text("Label")
    ///     .isHidden(true)
    /// ```
    ///
    /// Example for complete removal:
    /// ```
    /// Text("Label")
    ///     .isHidden(true, remove: true)
    /// ```
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

extension UIDevice {
    var hasNotch: Bool {
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0 > 20
    }
}

extension UIImage {
    func colorPixels(completion: @escaping (Int) -> Void) {
        guard let imageRef = self.cgImage, let colorSpace = imageRef.colorSpace else {
            completion(0)
            return
        }
        if colorSpace.model == .rgb {
            let dataProvider = imageRef.dataProvider
            let imageData = dataProvider?.data
            let rawData = CFDataGetBytePtr(imageData!)
            let width = imageRef.width
            let height = imageRef.height
            
            var colorPixels = 0
            
            for _ in 1...100 {
                let index = Int.random(in: 0..<(min(width, height)))
                let red = rawData![index]
                let green = rawData![index + 1]
                let blue = rawData![index + 2]
                if red != green || green != blue || red == 0 || red == 255 {
                    colorPixels += 1
                }
            }
            completion(colorPixels)
        }
        else if colorSpace.model == .monochrome {
            completion(0)
        }
    }
}

struct TextLabelWithHyperlink: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UITextView {
        
        let standartTextAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        let attributedText = NSMutableAttributedString(string: "During the fall, I wrote a research paper about machine learning in medicine. I learned and wrote about three subtopics. You can read my paper ")
        attributedText.addAttributes(standartTextAttributes, range: attributedText.range) // check extention
        
        let hyperlinkTextAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.link: "https://stackoverflow.com"
        ]
        
        let textWithHyperlink = NSMutableAttributedString(string: "here")
        textWithHyperlink.addAttributes(hyperlinkTextAttributes, range: textWithHyperlink.range)
        attributedText.append(textWithHyperlink)
        
        let endOfAttrString = NSMutableAttributedString(string: ".")
        endOfAttrString.addAttributes(standartTextAttributes, range: endOfAttrString.range)
        attributedText.append(endOfAttrString)
        
        let textView = UITextView()
        textView.attributedText = attributedText
        
        textView.isEditable = false
        textView.textAlignment = .left
        textView.isSelectable = false
        textView.backgroundColor = .clear
        
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {}
    
}

extension NSMutableAttributedString {
    
    var range: NSRange {
        NSRange(location: 0, length: self.length)
    }
    
}
