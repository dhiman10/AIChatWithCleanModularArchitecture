//
//  OnboardingCommunityInteractor.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 25.06.25.
//

import SwiftUI

@Observable
@MainActor
class OnboardingCommunityPresenter {
    
    private let interactor: OnboardingCommunityInteractor
    private let router: OnboardingCommunityRouter

    init(interactor: OnboardingCommunityInteractor, router: OnboardingCommunityRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func onContinueButtonPressed() {
        router.showOnboardingColorView(delegate: OnboardingColorDelegate())
    }
}
