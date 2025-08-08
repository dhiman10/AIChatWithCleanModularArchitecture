//
//  CreateAvatarInteractor.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftUI

@MainActor
protocol CreateAvatarInteractor {
    func trackEvent(event: LoggableEvent)
    func getAuthId() throws -> String
    func generateImage(input: String) async throws -> UIImage
    func createAvatar(avatar: AvatarModel, image: UIImage) async throws
}

extension CoreInteractor: CreateAvatarInteractor { }
