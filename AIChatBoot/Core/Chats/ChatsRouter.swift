//
//  ChatsRouter.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftUI

@MainActor
protocol ChatsRouter {
    func showChatView(delegate: ChatViewDelegate)
}

extension CoreRouter: ChatsRouter { }
