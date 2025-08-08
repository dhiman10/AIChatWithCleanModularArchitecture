//
//  ChatRowCellInteractor.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftUI

@MainActor
protocol ChatRowCellInteractor {
    var auth: UserAuthInfo? { get }
    func trackEvent(event: LoggableEvent)
    func getAvatar(id: String) async throws -> AvatarModel
    func getLastChatMessage(chatId: String) async throws -> ChatMessageModel?
}

extension CoreInteractor: ChatRowCellInteractor {}

@MainActor
struct AnyChatRowCellInteractor: ChatRowCellInteractor {
    let anyAuth: UserAuthInfo?
    let anyTrackEvent: ((LoggableEvent) -> Void)?
    let anyGetAvatar: (String) async throws -> AvatarModel
    let anyGetLastChatMessage: (String) async throws -> ChatMessageModel?
    
    init(
        auth: UserAuthInfo? = .mock(),
        trackEvent: ((LoggableEvent) -> Void)? = nil,
        getAvatar: @escaping (String) async throws -> AvatarModel,
        getLastChatMessage: @escaping (String) async throws -> ChatMessageModel?
    ) {
        self.anyAuth = auth
        self.anyTrackEvent = trackEvent
        self.anyGetAvatar = getAvatar
        self.anyGetLastChatMessage = getLastChatMessage
    }
    
    init(interactor: ChatRowCellInteractor) {
        self.anyAuth = interactor.auth
        self.anyTrackEvent = interactor.trackEvent
        self.anyGetAvatar = interactor.getAvatar
        self.anyGetLastChatMessage = interactor.getLastChatMessage
    }
    
    var auth: UserAuthInfo? {
        anyAuth
    }
    
    func trackEvent(event: LoggableEvent) {
        anyTrackEvent?(event)
    }
    
    func getAvatar(id: String) async throws -> AvatarModel {
        try await anyGetAvatar(id)
    }
    
    func getLastChatMessage(chatId: String) async throws -> ChatMessageModel? {
        try await anyGetLastChatMessage(chatId)
    }
}
