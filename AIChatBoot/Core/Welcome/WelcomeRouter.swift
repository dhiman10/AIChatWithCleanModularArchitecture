//
//  WelcomeRouter.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftUI

@MainActor
protocol WelcomeRouter {
    func showOnboardingIntroView(delegate: OnboardingIntroDelegate)
    func showCreateAccountView(delegate: CreateAccountDelegate, onDisappear: (() -> Void)?)
}

extension OnbRouter: WelcomeRouter { }
