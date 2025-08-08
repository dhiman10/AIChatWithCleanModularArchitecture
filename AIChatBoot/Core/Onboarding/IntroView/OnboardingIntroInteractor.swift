//
//  OnboardingIntroInteractor.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftUI

@MainActor
protocol OnboardingIntroInteractor {
    var onboardingCommunityTest: Bool { get }
    
    func trackEvent(event: LoggableEvent)
}

extension OnbInteractor: OnboardingIntroInteractor { }
