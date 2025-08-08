//
//  AIService.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 19.05.25.
//

import SwiftUI

protocol AIService: Sendable {
    func generateImage(input: String) async throws -> UIImage
    func generateText(chats: [AIChatModel]) async throws -> AIChatModel
}
