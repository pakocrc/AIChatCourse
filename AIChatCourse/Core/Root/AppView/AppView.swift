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
                ZStack {
                    Color.red
                        .edgesIgnoringSafeArea(.all)
                    Text("Tab bar")
                }
            },
            onboardingView: {
                ZStack {
                    Color.blue
                        .edgesIgnoringSafeArea(.all)

                    Text("Onboarding")
                }
            })
    }
}

#Preview {
    AppView(showTabBar: true)
}
