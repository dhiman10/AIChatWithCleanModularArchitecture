//
//  CoreBuilder.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 10.07.25.
//

import SwiftUI

@MainActor
struct RootBuilder: Builder {
    let interactor: RootInteractor
    let loogedInRIB: ()-> any Builder
    let loogedOutRIB: ()-> any Builder

    func build() -> AnyView {
        appView().any()
    }
    
    func appView() -> some View {
        AppView(
            presenter: AppPresenter(
                interactor: interactor
            ),
            tabbarView: {
                loogedInRIB().build()
            },
            onboardingView: {
                loogedOutRIB().build()
            }
        )
    }
    
}
