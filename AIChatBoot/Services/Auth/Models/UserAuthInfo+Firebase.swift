//
//  UserAuthInfo+Firebase.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 16.05.25.
//

import FirebaseAuth

extension UserAuthInfo {
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.creationDate = user.metadata.creationDate
        self.lastSignInDate = user.metadata.lastSignInDate
    }

}
