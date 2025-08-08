//
//  ChatRouter.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftUI

@MainActor
protocol ChatRouter {
    func dismissScreen()
    func showAlert(_ option: AlertType, title: String, subtitle: String?, buttons: (@Sendable () -> AnyView)?)
    func showAlert(error: Error)
    func showProfileModal(avatar: AvatarModel, onXMarkPressed: @escaping () -> Void)
    func dismissModal()
}

extension CoreRouter: ChatRouter { }
