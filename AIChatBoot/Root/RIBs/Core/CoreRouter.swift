//
//  CoreRouter.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftUI
import CustomRouting

typealias RouterView = CustomRouting.RouterView
typealias AlertType = CustomRouting.AlertType
typealias Router = CustomRouting.Router

@MainActor
struct CoreRouter: GlobalRouter {
    let router: Router
    let builder: CoreBuilder
    
    // MARK: Segues
    
    func showCategoryListView(delegate: CategoryListDelegate) {
        router.showScreen(.push) { router in
            builder.categoryListView(router: router, delegate: delegate)
        }
    }
    
    func showChatView(delegate: ChatViewDelegate) {
        router.showScreen(.push) { router in
            builder.chatView(router: router, delegate: delegate)
        }
    }
    
    func showDevSettingsView() {
        router.showScreen(.sheet) { router in
            builder.devSettingsView(router: router)
        }
    }
    
    func showSettingsView() {
        router.showScreen(.sheet) { router in
            builder.settingsView(router: router)
        }
    }

    func showCreateAccountView(delegate: CreateAccountDelegate, onDisappear: (() -> Void)? = nil) {
        router.showScreen(.sheet) { router in
            builder.createAccountView(router: router, delegate: delegate)
                .presentationDetents([.medium])
                .onDisappear {
                    onDisappear?()
                }
        }
    }
    
    func showCreateAvatarView(onDisappear: @escaping () -> Void) {
        router.showScreen(.fullScreenCover) { router in
            builder.createAvatarView(router: router)
                .onDisappear {
                    onDisappear()
                }
        }
    }
    
    func showAboutView(delegate: AboutDelegate) {
        router.showScreen(.push, destination: { router in
            builder.aboutView(router: router, delegate: delegate)
        })
    }

    func showPushNotificationModal(onEnablePressed: @escaping () -> Void, onCancelPressed: @escaping () -> Void) {
        router.showModal(
            backgroundColor: Color.black.opacity(0.6),
            transition: .move(edge: .bottom),
            destination: {
                CustomModalView(
                    title: "Enable push notifications?",
                    subtitle: "We'll send you reminders and updates!",
                    primaryButtonTitle: "Enable",
                    primaryButtonAction: {
                        onEnablePressed()
                    },
                    secondaryButtonTitle: "Cancel",
                    secondaryButtonAction: {
                        onCancelPressed()
                    }
                )
            }
        )
    }
    
    func showProfileModal(avatar: AvatarModel, onXMarkPressed: @escaping () -> Void) {
        router.showModal(backgroundColor: Color.black.opacity(0.6), transition: .slide) {
            ProfileModalView(
                imageName: avatar.profileImageName,
                title: avatar.name,
                subtitle: avatar.characterOption?.rawValue.capitalized,
                headline: avatar.characterDescription,
                onXMarkPressed: {
                    onXMarkPressed()
                }
            )
            .padding(40)
        }
    }
    
    func showRatingsModal(onYesPressed: @escaping () -> Void, onNoPressed: @escaping () -> Void) {
        router.showModal(backgroundColor: Color.black.opacity(0.6), transition: .fade) {
            CustomModalView(
                title: "Are you enjoying AIChat?",
                subtitle: "We'd love to hear your feedback!",
                primaryButtonTitle: "Yes",
                primaryButtonAction: {
                    onYesPressed()
                },
                secondaryButtonTitle: "No",
                secondaryButtonAction: {
                    onNoPressed()
                }
            )
        }
    }

}
