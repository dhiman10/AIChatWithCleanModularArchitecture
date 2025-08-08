//
//  OnboardingCompletedRouter.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftUI

@MainActor
protocol OnboardingCompletedRouter {
    func showAlert(error: Error)
}

extension OnbRouter: OnboardingCompletedRouter { }
