//
//  OnbInteractor.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 10.07.25.
//

import SwiftUI

@MainActor
struct OnbInteractor {
    private let logManager: LogManager
    private let appState: AppState
    private let abTestManager: ABTestManager
    private let userManager: UserManager
    private let authManager: AuthManager
    
    init(container: DependencyContainer) {
        self.authManager = container.resolve(AuthManager.self)!
        self.userManager = container.resolve(UserManager.self)!
        self.logManager = container.resolve(LogManager.self)!
        self.abTestManager = container.resolve(ABTestManager.self)!
        self.appState = container.resolve(AppState.self)!
    }
    
    func trackEvent(event: any LoggableEvent) {
        logManager.trackEvent(event: event)
    }
    
    func updateAppState(showTabBarView: Bool) {
        appState.updateViewState(showTabBarView: showTabBarView)
    }

    var onboardingCommunityTest: Bool {
        abTestManager.activeTests.onboardingCommunityTest
    }

    func markOnboardingCompleteForCurrentUser(profileColorHex: String) async throws {
        try await userManager.markOnboardingCompleteForCurrentUser(profileColorHex: profileColorHex)
    }
    
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        try await authManager.signInApple()
    }
    
    func logIn(user: UserAuthInfo, isNewUser: Bool) async throws {
        try await userManager.logIn(auth: user, isNewUser: isNewUser)
    }
}
