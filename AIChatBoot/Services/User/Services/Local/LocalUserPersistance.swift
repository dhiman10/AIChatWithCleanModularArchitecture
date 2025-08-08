//
//  LocalUserPersistence.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 19.05.25.
//

protocol LocalUserPersistence {
    func getCurrentUser() -> UserModel?
    func saveCurrentUser(user: UserModel?) throws
}
