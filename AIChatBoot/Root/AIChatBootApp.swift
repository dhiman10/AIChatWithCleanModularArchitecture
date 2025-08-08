//
//  AIChatBootApp.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 06.05.25.
//

import Firebase
import SwiftUI

@main
struct AIChatBootApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            delegate.builder.build()
                .environment(delegate.dependencies.logManager)
        }
    }
}

extension View {
    func previewEnvironment(isSignedIn: Bool = true) -> some View {
        self
            .environment(LogManager(services: []))
    }
}
