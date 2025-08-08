//
//  LocalAvatarPersistence.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 21.05.25.
//

@MainActor
protocol LocalAvatarPersistence {
    func addRecentAvatar(avatar: AvatarModel) throws
    func getRecentAvatars() throws -> [AvatarModel]
}
