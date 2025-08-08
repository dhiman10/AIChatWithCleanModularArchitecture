//
//  ChatRowCellInteractor.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 24.06.25.
//

import SwiftUI

@Observable
@MainActor
class ChatRowCellPresenter {
    private let interactor: ChatRowCellInteractor

    var currentUserId: String? = ""

    private(set) var avatar: AvatarModel?
    private(set) var lastChatMessage: ChatMessageModel?

    private(set) var didLoadAvatar: Bool = false
    private(set) var didLoadChatMessage: Bool = false

    init(interactor: ChatRowCellInteractor) {
        self.interactor = interactor
    }

    var isLoading: Bool {
        if didLoadAvatar && didLoadChatMessage {
            return false
        }

        return true
    }

    var hasNewChat: Bool {
        guard let lastChatMessage, let currentUserId else { return false }
        return !lastChatMessage.hasBeenSeenBy(userId: currentUserId)
    }

    var subheadline: String? {
        if isLoading {
            return "xxxx xxxx xxxxx xxxx"
        }

        if avatar == nil, lastChatMessage == nil {
            return "Error"
        }

        return lastChatMessage?.content?.message
    }

    func loadAvatar(chat: ChatModel) async {
        avatar = try? await interactor.getAvatar(id: chat.avatarId)
        didLoadAvatar = true
    }

    func loadLastChatMessage(chat: ChatModel) async {
        lastChatMessage = try? await interactor.getLastChatMessage(chatId: chat.id)
        didLoadChatMessage = true
    }
}
