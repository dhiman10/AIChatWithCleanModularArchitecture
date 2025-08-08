//
//  ProfileInteractor.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftUI
@MainActor
protocol ProfileInteractor {
    var currentUser: UserModel? { get }
    func getAuthId() throws -> String
    func getAvatarsForAuthor(userId: String) async throws -> [AvatarModel]
    func removeAuthorIdFromAvatar(avatarId: String) async throws
    func trackEvent(event: LoggableEvent)
}

extension CoreInteractor: ProfileInteractor { }
