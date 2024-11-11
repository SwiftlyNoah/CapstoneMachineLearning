//
//  ViewModifiers.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 2/1/21.
//

import SwiftUI

struct DemoNotificationModifier: ViewModifier {
    var imageName: String
    var notificationName: String
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                NotificationCenter.default.post(name: NSNotification.Name(notificationName),
                                                object: nil, userInfo: ["imageName": imageName])
            }
    }
}

extension View {
    func withNotification(imageName: String, notificationName: String) -> some View {
        self.modifier(DemoNotificationModifier(imageName: imageName, notificationName: notificationName))
    }
}

struct SwipeGestureModifier: ViewModifier {
    var toTheRight: Bool
    var completion: () -> Void
    
    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded { value in
                        if value.translation.width > 0 && !toTheRight {
                            // left
                            completion()
                        }
                        else if value.translation.width < 0 && toTheRight {
                            // right
                            completion()
                        }
                    }
            )
    }
}

extension View {
    func wtihDrag(toTheRight: Bool, completion: @escaping () -> Void) -> some View {
        self.modifier(SwipeGestureModifier(toTheRight: toTheRight, completion: completion))
    }
}
