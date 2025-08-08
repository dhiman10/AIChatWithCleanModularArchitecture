//
//  OnboardingIntropresenter.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 25.06.25.
//

import SwiftUI

@Observable
@MainActor
class OnboardingIntroPresenter {
    
    private let interactor: OnboardingIntroInteractor
    private let router: OnboardingIntroRouter

    init(interactor: OnboardingIntroInteractor, router: OnboardingIntroRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func onContinueButtonPressed() {
        if interactor.onboardingCommunityTest {
            router.showOnboardingCommunityView(delegate: OnboardingCommunityDelegate())
        } else {
            router.showOnboardingColorView(delegate: OnboardingColorDelegate())
        }
    }
}
