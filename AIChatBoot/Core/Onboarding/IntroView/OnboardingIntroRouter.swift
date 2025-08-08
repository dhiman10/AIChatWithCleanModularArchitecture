//
//  OnboardingIntroRouter.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//
import SwiftUI

@MainActor
protocol OnboardingIntroRouter {
    func showOnboardingCommunityView(delegate: OnboardingCommunityDelegate)
    func showOnboardingColorView(delegate: OnboardingColorDelegate)
}

extension OnbRouter: OnboardingIntroRouter { }
