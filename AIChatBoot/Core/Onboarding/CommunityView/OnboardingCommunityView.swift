//
//  OnboardingCommunityView.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 16.06.25.
//

import SwiftUI

struct OnboardingCommunityDelegate {
}

struct OnboardingCommunityView: View {
    
    @State var presenter: OnboardingCommunityPresenter
    let delegate: OnboardingCommunityDelegate

    var body: some View {
        VStack {
            VStack(spacing: 40) {
                ImageLoaderView()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                
                Group {
                    Text("Join our community with over ")
                    +
                    Text("1000+ ")
                        .foregroundStyle(.accent)
                        .fontWeight(.semibold)
                    +
                    Text("custom avatars.\n\nAsk them questions or have a casual conversation!")
                }
                .baselineOffset(6)
                .minimumScaleFactor(0.5)
                .padding(24)
            }
            .frame(maxHeight: .infinity)

            Text("Continue")
                .callToActionButton()
                .accessibilityIdentifier("OnboardingCommunityContinueButton")
                .anyButton(.press) {
                    presenter.onContinueButtonPressed()
                }
        }
        .padding(24)
        .font(.title3)
        .toolbar(.hidden, for: .navigationBar)
        .screenAppearAnalytics(name: "OnboardingCommunityView")
    }
}

#Preview {
    let builder = OnbBuilder(interactor: OnbInteractor(container: DevPreview.shared.container))
    
    return RouterView { router in
        builder.onboardingCommunityView(router: router, delegate: OnboardingCommunityDelegate())
    }
    .previewEnvironment()
}
