//
//  CreateAvatarRouter.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//
import SwiftUI

@MainActor
protocol CreateAvatarRouter {
    func dismissScreen()
    func showAlert(error: Error)
}

extension CoreRouter: CreateAvatarRouter { }
