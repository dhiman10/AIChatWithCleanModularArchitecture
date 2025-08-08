//
//  SettingsInteractor.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftfulUtilities
import SwiftUI

@MainActor
protocol SettingsInteractor {
    var auth: UserAuthInfo? { get }

    func trackEvent(event: LoggableEvent)
    func signOut() async throws
    func deleteAccount() async throws
    func updateAppState(showTabBarView: Bool)
}

extension CoreInteractor: SettingsInteractor {}
