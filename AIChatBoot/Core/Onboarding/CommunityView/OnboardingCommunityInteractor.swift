//
//  OnboardingCommunityInteractor.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftUI

@MainActor
protocol OnboardingCommunityInteractor {
    func trackEvent(event: LoggableEvent)
}

extension OnbInteractor: OnboardingCommunityInteractor { }
