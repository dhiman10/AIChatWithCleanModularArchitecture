//
//  SettingsRouter.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftfulUtilities
import SwiftUI

@MainActor
protocol SettingsRouter {
    func showCreateAccountView(delegate: CreateAccountDelegate, onDisappear: (() -> Void)?)
    func dismissScreen()
    
    func showAlert(error: Error)
    func showAlert(_ option: AlertType, title: String, subtitle: String?, buttons: (@Sendable () -> AnyView)?)
    
    func showRatingsModal(onYesPressed: @escaping () -> Void, onNoPressed: @escaping () -> Void)
    func showAboutView(delegate: AboutDelegate)
    func dismissModal()
}
extension CoreRouter: SettingsRouter { }
