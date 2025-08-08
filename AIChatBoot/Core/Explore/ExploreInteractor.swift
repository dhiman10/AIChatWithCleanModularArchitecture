//
//  ExploreInteractor.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftUI

@MainActor
protocol ExploreInteractor {
    var categoryRowTest: CategoryRowTestOption { get }
    var createAccountTest: Bool { get }
    var auth: UserAuthInfo? { get }
    
    func requestAuthorization() async throws -> Bool
    func schedulePushNotificationsForTheNextWeek()
    func canRequestAuthorization() async -> Bool
    func trackEvent(event: LoggableEvent)
    
    func getFeaturedAvatars() async throws -> [AvatarModel]
    func getPopularAvatars() async throws -> [AvatarModel]
}

extension CoreInteractor: ExploreInteractor {}
