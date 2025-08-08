//
//  CreateAccountRouter.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//
import SwiftUI

@MainActor
protocol CreateAccountRouter {
    func dismissScreen()
}

extension CoreRouter: CreateAccountRouter { }
extension OnbRouter: CreateAccountRouter { }
