//
//  CreateAccountInteractor.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 09.07.25.
//

import SwiftUI

@MainActor
protocol CreateAccountInteractor {
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func trackEvent(event: LoggableEvent)
    func logIn(user: UserAuthInfo, isNewUser: Bool) async throws
}

extension CoreInteractor: CreateAccountInteractor {}
extension OnbInteractor: CreateAccountInteractor {}
