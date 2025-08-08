//
//  SettingsInteractor.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 25.06.25.
//

import SwiftfulUtilities
import SwiftUI

@Observable
@MainActor
class SettingsPresenter {
    private let interactor: SettingsInteractor
    private let router: SettingsRouter

    private(set) var isAnonymousUser: Bool = false
    private(set) var isPremium: Bool = false

    init(interactor: SettingsInteractor, router: SettingsRouter) {
        self.interactor = interactor
        self.router = router
    }

    func onRatingsButtonPressed() {
        interactor.trackEvent(event: Event.ratingsPressed)
        
        func onEnjoyingAppYesPressed() {
            interactor.trackEvent(event: Event.ratingsYesPressed)
            router.dismissModal()
            AppStoreRatingsHelper.requestRatingsReview()
        }

        func onEnjoyingAppNoPressed() {
            interactor.trackEvent(event: Event.ratingsNoPressed)
            router.dismissModal()
        }
        
        router
            .showRatingsModal(
                onYesPressed: onEnjoyingAppYesPressed,
                onNoPressed: onEnjoyingAppNoPressed
            )
        
    }

    func onCreateAccountPressed() {
        interactor.trackEvent(event: Event.createAccountPressed)
        let delegate = CreateAccountDelegate()

        router.showCreateAccountView(delegate: delegate, onDisappear: {
            self.setAnonymousAccountStatus()
        })
    }

    func setAnonymousAccountStatus() {
        isAnonymousUser = interactor.auth?.isAnonymous == true
    }

    func onContactUsPressed() {
        interactor.trackEvent(event: Event.contactUsPressed)
        let email = "haha@gmail.com"
        let emailString = "mailto:\(email)"

        guard let url = URL(string: emailString), UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url)
    }

    func onSignOutPressed() {
        interactor.trackEvent(event: Event.signOutStart)
        Task {
            do {
                try await interactor.signOut()
                interactor.trackEvent(event: Event.signOutSuccess)
                await dismissScreen()
            } catch {
                router.showAlert(error: error)
                interactor.trackEvent(event: Event.signOutFail(error: error))
            }
        }
    }
    
    private func dismissScreen() async {
        router.dismissScreen()
        try? await Task.sleep(for: .seconds(1))
        interactor.updateAppState(showTabBarView: false)
    }

    func onDeleteAccountPressed() {
        interactor.trackEvent(event: Event.deleteAccountStart)
        
        router
            .showAlert(
                .alert,
                title: "Delete Account?",
                subtitle: "This action is permanent and cannot be undone. Your data will be deleted from our server forever.",
                buttons: {
                    AnyView(
                        Button("Delete", role: .destructive, action: {
                            self.onDeleteAccountConfirmed()
                        })
                    )
                }
            )
    }

    private func onDeleteAccountConfirmed() {
        interactor.trackEvent(event: Event.deleteAccountStartConfirm)

        Task {
            do {
                try await interactor.deleteAccount()
                interactor.trackEvent(event: Event.deleteAccountSuccess)
                await dismissScreen()
            } catch {
                router.showAlert(error: error)
                interactor.trackEvent(event: Event.deleteAccountFail(error: error))
            }
        }
    }
    
    func onAboutUsPressed() {
        router.showAboutView(delegate: AboutDelegate())
    }

    enum Event: LoggableEvent {
        case signOutStart
        case signOutSuccess
        case signOutFail(error: Error)
        case deleteAccountStart
        case deleteAccountStartConfirm
        case deleteAccountSuccess
        case deleteAccountFail(error: Error)
        case createAccountPressed
        case contactUsPressed
        case ratingsPressed
        case ratingsYesPressed
        case ratingsNoPressed

        var eventName: String {
            switch self {
            case .signOutStart: return "SettingsView_SignOut_Start"
            case .signOutSuccess: return "SettingsView_SignOut_Success"
            case .signOutFail: return "SettingsView_SignOut_Fail"
            case .deleteAccountStart: return "SettingsView_DeleteAccount_Start"
            case .deleteAccountStartConfirm: return "SettingsView_DeleteAccount_StartConfirm"
            case .deleteAccountSuccess: return "SettingsView_DeleteAccount_Success"
            case .deleteAccountFail: return "SettingsView_DeleteAccount_Fail"
            case .createAccountPressed: return "SettingsView_CreateAccount_Pressed"
            case .contactUsPressed: return "SettingsView_ContactUs_Pressed"
            case .ratingsPressed: return "SettingsView_Ratings_Pressed"
            case .ratingsYesPressed: return "SettingsView_RatingsYes_Pressed"
            case .ratingsNoPressed: return "SettingsView_RatingsNo_Pressed"
            }
        }

        var parameters: [String: Any]? {
            switch self {
            case .signOutFail(error: let error), .deleteAccountFail(error: let error):
                return error.eventParameters
            default:
                return nil
            }
        }

        var type: LogType {
            switch self {
            case .signOutFail, .deleteAccountFail:
                return .severe
            default:
                return .analytic
            }
        }
    }
}
