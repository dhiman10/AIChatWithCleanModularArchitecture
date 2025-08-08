//
//  CategoryListRouter.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftUI

@MainActor
protocol CategoryListRouter {
    func showAlert(error: Error)
    func showChatView(delegate: ChatViewDelegate)
}

extension CoreRouter: CategoryListRouter { }
