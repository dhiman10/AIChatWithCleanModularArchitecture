//
//  AppearAnalyticsViewModifier.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 11.06.25.
//

import SwiftUI

struct AppearAnalyticsViewModifier: ViewModifier {
    @Environment(LogManager.self) private var logManager
    let name: String
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                logManager.trackScreenEvent(event: Event.appear(name: name))
            }
            .onDisappear {
                logManager.trackScreenEvent(event: Event.disappear(name: name))
            }
    }
    
    enum Event: LoggableEvent {
        case appear(name: String)
        case disappear(name: String)
        
        var eventName: String {
            switch self {
            case .appear(name: let name):           return "\(name)_Appear"
            case .disappear(name: let name):        return "\(name)_Disappear"
            }
        }
        
        var parameters: [String: Any]? {
            nil
        }
        
        var type: LogType {
            .analytic
        }

    }
}

extension View {
    func screenAppearAnalytics(name: String) -> some View {
        modifier(AppearAnalyticsViewModifier(name: name))
    }
}
