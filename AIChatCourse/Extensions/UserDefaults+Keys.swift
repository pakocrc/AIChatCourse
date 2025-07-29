//
//  Keys.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import Foundation

extension UserDefaults {
   
    // MARK: - Keys
    private struct Keys {
        static let showTabBar = "showTabBar"
    }
    
    static var showTabBar: Bool {
        get {
            standard.bool(forKey: Keys.showTabBar)
        } set {
            standard.set(newValue, forKey: Keys.showTabBar)
        }
    }
}
