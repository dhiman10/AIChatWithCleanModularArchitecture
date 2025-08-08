//
//  Buildable.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 10.07.25.
//

import SwiftUI

@MainActor
protocol Builder {
    func build() -> AnyView
}
