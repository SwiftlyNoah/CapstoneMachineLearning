//
//  Layout2.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 2/1/21.
//

import SwiftUI

struct DemoLayout1: View {
    
    var images: [Int]
    
    var body: some View {
        
        HStack(spacing: 4){
            Image(String(images[0]))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: ((width / 3)), height: 125)
                .cornerRadius(4)
                .withNotification(imageName: String(images[0]), notificationName: "DemoImageTapped")

            Image(String(images[1]))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width / 3, height: 125)
                .cornerRadius(4)
                .withNotification(imageName: String(images[1]), notificationName: "DemoImageTapped")

            Image(String(images[2]))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width / 3, height: 125)
                .cornerRadius(4)
                .withNotification(imageName: String(images[2]), notificationName: "DemoImageTapped")

        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
