//
//  ChatsInteractor.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftUI

@MainActor
protocol ChatsInteractor {
    
    var auth: UserAuthInfo? { get }
    
    func trackEvent(event: LoggableEvent)
    func getRecentAvatars() throws -> [AvatarModel]
    func getAuthId() throws -> String
    func getAllChats(userId: String) async throws -> [ChatModel]
    func getAvatar(id: String) async throws -> AvatarModel
    func getLastChatMessage(chatId: String) async throws -> ChatMessageModel?

}

extension CoreInteractor: ChatsInteractor { }
