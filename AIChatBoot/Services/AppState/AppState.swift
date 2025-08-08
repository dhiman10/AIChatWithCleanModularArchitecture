//
//  AppState.swift
//  AIChatBoot
//
//  Created by Dhiman Das on 06.05.25.
//

import SwiftUI

@Observable
class AppState {
    
    private(set) var showTabBar: Bool {
        didSet {
            UserDefaults.showTabbarView = showTabBar
        }
    }
    init(showTabBar: Bool = UserDefaults.showTabbarView) {
        self.showTabBar = showTabBar
    }
    
    func updateViewState(showTabBarView: Bool) {
        showTabBar = showTabBarView
    }
}

fileprivate extension UserDefaults {

    private struct Keys {
        static let showTabbarView = "showTabbarView"
    }

    static var showTabbarView: Bool {
        get {
            standard.bool(forKey: Keys.showTabbarView)
        }
        set {
            standard.set(newValue, forKey: Keys.showTabbarView)
        }
    }
    
}
