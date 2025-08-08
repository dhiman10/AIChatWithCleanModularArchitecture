//
//  ChatsInteractor.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 24.06.25.
//

import SwiftUI

@Observable
@MainActor
class ChatsPresenter {
    private let interactor: ChatsInteractor
    private let router: ChatsRouter

    private(set) var chats: [ChatModel] = []
    private(set) var isLoadingChats: Bool = true
    private(set) var recentAvatars: [AvatarModel] = []

    init(interactor: ChatsInteractor, router: ChatsRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func loadRecentAvatars() {
        interactor.trackEvent(event: Event.loadAvatarsStart)
        do {
            recentAvatars = try interactor.getRecentAvatars()
            interactor.trackEvent(event: Event.loadAvatarsSuccess(avatarCount: recentAvatars.count))
        } catch {
            interactor.trackEvent(event: Event.loadAvatarsFail(error: error))
        }
    }
    
    func loadChats() async {
        interactor.trackEvent(event: Event.loadChatsStart)

        do {
            let uid = try interactor.getAuthId()
            chats = try await interactor.getAllChats(userId: uid)
                .sortedByKeyPath(keyPath: \.dateModified, ascending: false)
            interactor.trackEvent(event: Event.loadChatsSuccess(chatsCount: chats.count))
            
        } catch {
            interactor.trackEvent(event: Event.loadChatsFail(error: error))
        }
        
        isLoadingChats = false
    }
    
    func onChatPressed(chat: ChatModel) {
        interactor.trackEvent(event: Event.chatPressed(chat: chat))
        let delegate = ChatViewDelegate(chat: chat, avatarId: chat.avatarId)
        router.showChatView(delegate: delegate)
        
    }

    func onAvatarPressed(avatar: AvatarModel) {        
        interactor.trackEvent(event: Event.avatarPressed(avatar: avatar))
        let delegate = ChatViewDelegate(chat: nil, avatarId: avatar.avatarId)
        router.showChatView(delegate: delegate)

    }
    
    enum Event: LoggableEvent {
        case loadAvatarsStart
        case loadAvatarsSuccess(avatarCount: Int)
        case loadAvatarsFail(error: Error)
        case loadChatsStart
        case loadChatsSuccess(chatsCount: Int)
        case loadChatsFail(error: Error)
        case chatPressed(chat: ChatModel)
        case avatarPressed(avatar: AvatarModel)

        var eventName: String {
            switch self {
            case .loadAvatarsStart:        return "ChatsView_LoadAvatars_Start"
            case .loadAvatarsSuccess:      return "ChatsView_LoadAvatars_Success"
            case .loadAvatarsFail:         return "ChatsView_LoadAvatars_Fail"
            case .loadChatsStart:          return "ChatsView_LoadChats_Start"
            case .loadChatsSuccess:        return "ChatsView_LoadChats_Success"
            case .loadChatsFail:           return "ChatsView_LoadChats_Fail"
            case .chatPressed:             return "ChatsView_Chat_Pressed"
            case .avatarPressed:           return "ChatsView_Avatar_Pressed"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .loadAvatarsSuccess(avatarCount: let avatarCount):
                return [
                    "avatars_count": avatarCount
                ]
            case .loadChatsSuccess(chatsCount: let chatsCount):
                return [
                    "chats_count": chatsCount
                ]
            case .loadAvatarsFail(error: let error), .loadChatsFail(error: let error):
                return error.eventParameters
            case .chatPressed(chat: let chat):
                return chat.eventParameters
            case .avatarPressed(avatar: let avatar):
                return avatar.eventParameters
            default:
                return nil
            }
        }
        
        var type: LogType {
            switch self {
            case .loadAvatarsFail, .loadChatsFail:
                return .severe
            default:
                return .analytic
            }
        }
    }
    
}
