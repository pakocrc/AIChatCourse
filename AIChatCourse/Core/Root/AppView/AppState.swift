//
//  AppState.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

@Observable
class AppState {
    private(set) var showTabBar: Bool {
        didSet {
            UserDefaults.showTabBar = showTabBar
        }
    }

    init(showTabBar: Bool = UserDefaults.showTabBar) {
        self.showTabBar = showTabBar
    }

    func updateViewState(showTabBar: Bool) {
        self.showTabBar = showTabBar
    }
}
