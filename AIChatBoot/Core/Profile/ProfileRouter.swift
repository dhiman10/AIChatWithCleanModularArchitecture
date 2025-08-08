//
//  ProfileRouter.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

@MainActor
protocol ProfileRouter {
    func showSettingsView()
    func showCreateAvatarView(onDisappear: @escaping () -> Void)
    func showChatView(delegate: ChatViewDelegate)
    func showSimpleAlert(title: String, subtitle: String?)
}
extension CoreRouter: ProfileRouter { }
