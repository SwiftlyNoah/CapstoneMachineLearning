//
//  Layout3.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 2/1/21.
//

import SwiftUI

struct DemoLayout3: View {
    
    var images: [Int]
    
    var body: some View {
        HStack(spacing: 4) {
            VStack(spacing: 4){
                
                Image(String(images[0]))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width / 3, height: 123)
                    .cornerRadius(4)
                    .withNotification(imageName: String(images[0]), notificationName: "DemoImageTapped")
                
                Image(String(images[1]))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width / 3, height: 123)
                    .cornerRadius(4)
                    .withNotification(imageName: String(images[1]), notificationName: "DemoImageTapped")
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            Image(String(images[2]))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width - (width / 3) + 4, height: 250)
                .cornerRadius(4)
                .withNotification(imageName: String(images[2]), notificationName: "DemoImageTapped")
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}
