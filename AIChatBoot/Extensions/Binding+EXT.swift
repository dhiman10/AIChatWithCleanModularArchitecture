//
//  Binding+EXT.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 13.05.25.
//

import SwiftUI
import Foundation

extension Binding where Value == Bool {
    init<T: Sendable>(ifNotNil value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}
