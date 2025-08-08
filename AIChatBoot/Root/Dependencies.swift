//
//  Dependencies.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 25.06.25.
//

import SwiftUI

@MainActor
struct Dependencies {
    let container: DependencyContainer
    let logManager: LogManager

    init(config: BuildConfiguration) {
        
        let authManager: AuthManager
        let userManager: UserManager
        let abTestManager: ABTestManager
        let appState: AppState
        
        let aiService: AIService
        let localAvatarService: LocalAvatarPersistence
        let remoteAvatarService: RemoteAvatarService
        let chatService: ChatService
        
        switch config {
        case .mock(isSignedIn: let isSignedIn):
            logManager = LogManager(services: [
                ConsoleService(printParameters: false)
            ])
            authManager = AuthManager(service: MockAuthService(user: isSignedIn ? .mock() : nil), logManager: logManager)
            userManager = UserManager(services: MockUserServices(user: isSignedIn ? .mock : nil), logManager: logManager)
            aiService = MockAIService()
            localAvatarService = MockLocalAvatarPersistence()
            remoteAvatarService = MockAvatarService()
            chatService = MockChatService()
            abTestManager = ABTestManager(service: MockABTestService(), logManager: logManager)
            appState = AppState(showTabBar: isSignedIn)

        case .dev:
            logManager = LogManager(services: [
                ConsoleService(printParameters: true),
                FirebaseAnalyticsService(),
                // MixpanelService(token: Keys.mixpanelToken),
                FirebaseCrashlyticsService()
            ])
            authManager = AuthManager(service: FirebaseAuthService(), logManager: logManager)
            userManager = UserManager(services: ProductionUserServices(), logManager: logManager)
            aiService = OpenAIService()
            localAvatarService = SwiftDataLocalAvatarPersistence()
            remoteAvatarService = FirebaseAvatarService()
            chatService = FirebaseChatService()
            abTestManager = ABTestManager(service: LocalABTestService(), logManager: logManager)
            appState = AppState()

        case .prod:
            logManager = LogManager(services: [
                FirebaseAnalyticsService(),
                // MixpanelService(token: Keys.mixpanelToken),
                FirebaseCrashlyticsService()
            ])
            authManager = AuthManager(service: FirebaseAuthService(), logManager: logManager)
            userManager = UserManager(services: ProductionUserServices(), logManager: logManager)
            aiService = OpenAIService()
            localAvatarService = SwiftDataLocalAvatarPersistence()
            remoteAvatarService = FirebaseAvatarService()
            chatService = FirebaseChatService()
            abTestManager = ABTestManager(service: FirebaseABTestService(), logManager: logManager)
            appState = AppState()
        }


        let container = DependencyContainer()
        container.register(AuthManager.self, service: authManager)
        container.register(UserManager.self, service: userManager)
        container.register(LogManager.self, service: logManager)
        container.register(ABTestManager.self, service: abTestManager)
        container.register(AppState.self, service: appState)
        
        container.register(AIService.self, service: aiService)
        container.register(LocalAvatarPersistence.self, service: localAvatarService)
        container.register(RemoteAvatarService.self, service: remoteAvatarService)
        container.register(ChatService.self, service: chatService)
        
        self.container = container
    }
}

@MainActor
class DevPreview {
    static let shared = DevPreview()

    var container: DependencyContainer {
        let container = DependencyContainer()
        container.register(AuthManager.self, service: authManager)
        container.register(UserManager.self, service: userManager)
        container.register(LogManager.self, service: logManager)
        container.register(ABTestManager.self, service: abTestManager)
        container.register(AppState.self, service: appState)
        
        container.register(AIService.self, service: aiService)
        container.register(LocalAvatarPersistence.self, service: localAvatarService)
        container.register(RemoteAvatarService.self, service: remoteAvatarService)
        container.register(ChatService.self, service: chatService)
        
        return container
    }

    let authManager: AuthManager
    let userManager: UserManager
    let logManager: LogManager
    let abTestManager: ABTestManager
    let appState: AppState
    
    let aiService: AIService
    let localAvatarService: LocalAvatarPersistence
    let remoteAvatarService: RemoteAvatarService
    let chatService: ChatService

    init(isSignedIn: Bool = true) {
        self.authManager = AuthManager(service: MockAuthService(user: isSignedIn ? .mock() : nil))
        self.userManager = UserManager(services: MockUserServices(user: isSignedIn ? .mock : nil))
        self.logManager = LogManager(services: [])
        self.abTestManager = ABTestManager(service: MockABTestService())
        self.appState = AppState()
        
        self.aiService = MockAIService()
        self.localAvatarService = MockLocalAvatarPersistence()
        self.remoteAvatarService = MockAvatarService()
        self.chatService = MockChatService()
        
    }
}
