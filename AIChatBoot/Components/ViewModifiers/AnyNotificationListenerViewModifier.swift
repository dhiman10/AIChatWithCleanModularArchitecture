//
//  AppearAnalyticsViewModifier.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 11.06.25.
//

import Foundation
import SwiftUI

struct AnyNotificationListenerViewModifier: ViewModifier {
    
    let notificationName: Notification.Name
    let onNotificationRecieved: @MainActor (Notification) -> Void
    
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: notificationName), perform: { notification in
                onNotificationRecieved(notification)
            })
    }
}

extension View {
    
    func onNotificationRecieved(name: Notification.Name, action: @MainActor @escaping (Notification) -> Void) -> some View {
        modifier(AnyNotificationListenerViewModifier(notificationName: name, onNotificationRecieved: action))
    }
}
