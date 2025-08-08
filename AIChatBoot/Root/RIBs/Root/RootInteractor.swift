//
//  RootInteractor.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 10.07.25.
//
import SwiftUI

@MainActor
struct RootInteractor {
    private let authManager: AuthManager
    private let appState: AppState
    private let logManager: LogManager
    private let userManager: UserManager
    
    init(container: DependencyContainer) {
        self.authManager = container.resolve(AuthManager.self)!
        self.appState = container.resolve(AppState.self)!
        self.logManager = container.resolve(LogManager.self)!
        self.userManager = container.resolve(UserManager.self)!
    }
    
    // MARK: AuthManager

    var auth: UserAuthInfo? {
        authManager.auth
    }
    
    var showTabBar: Bool {
        appState.showTabBar
    }
    
    func trackEvent(event: any LoggableEvent) {
        logManager.trackEvent(event: event)
    }
    
    func logIn(user: UserAuthInfo, isNewUser: Bool) async throws {
        try await userManager.logIn(auth: user, isNewUser: isNewUser)
    }
    
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        try await authManager.signInAnonymously()
    }
}
