//
//  DemoImagePicker.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 2/1/21.
//

import SwiftUI

struct DemoPicker: View {

    @State var pneumoniaIndex = 0
    
    @Environment(\.presentationMode) var presentaionMode
    
    let demoTappedPub = NotificationCenter.default
        .publisher(for: NSNotification.Name("DemoImageTapped"))
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 4) {
                        DemoLayout2(images: [0+pneumoniaIndex * 9, 1+pneumoniaIndex * 9, 2+pneumoniaIndex * 9])
                        DemoLayout1(images: [3+pneumoniaIndex * 9, 4+pneumoniaIndex * 9, 5+pneumoniaIndex * 9])
                        DemoLayout3(images: [6+pneumoniaIndex * 9, 7+pneumoniaIndex * 9, 8+pneumoniaIndex * 9])
                    }
                }
                .padding()
                .navigationBarTitle(pneumoniaIndex == 0 ? "Normal" : "Pneumonia")
                .navigationBarItems(
                    leading:
                        Button(action: {
                            presentaionMode.wrappedValue.dismiss()
                        }) {
                            Text("Cancel")
                                .fontWeight(.regular)
                        }
                    ,
                    trailing:
                            Picker(selection: self.$pneumoniaIndex, label: Text("Pick One")) {
                                Text("Normal").tag(0)
                                Text("Pneumonia").tag(1)
                            }
                            .frame(width: 250)
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.trailing, geometry.size.width/2-150)
                        
                )
            }
        }
        .onReceive(demoTappedPub) {_ in
            presentaionMode.wrappedValue.dismiss()
        }
    }
}
