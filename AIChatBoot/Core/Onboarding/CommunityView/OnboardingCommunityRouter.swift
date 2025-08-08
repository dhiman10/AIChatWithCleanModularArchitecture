//
//  OnboardingCommunityRouter.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftUI

@MainActor
protocol OnboardingCommunityRouter {
    func showOnboardingColorView(delegate: OnboardingColorDelegate)
}

extension OnbRouter: OnboardingCommunityRouter { }
