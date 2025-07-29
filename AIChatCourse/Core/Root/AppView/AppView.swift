//
//  AppView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct AppView: View {
    @AppStorage("showTabBarView") var showTabBar: Bool = false

    var body: some View {
        AppViewBuilder(
            showTabBar: showTabBar,
            tabBarView: {
                TabBarView()
            },
            onboardingView: {
                WelcomeView()
            })
    }
}

#Preview {
    AppView(showTabBar: true)
}

#Preview {
    AppView(showTabBar: false)
}
