//
//  AppViewBuilder.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct AppViewBuilder<TabBarView: View, OnboardingView: View>: View {
    var showTabBar: Bool = false

    @ViewBuilder var tabBarView: TabBarView
    @ViewBuilder var onboardingView: OnboardingView

    var body: some View {
        ZStack {
            if showTabBar {
                tabBarView
                    .transition(.move(edge: .trailing))

            } else {
                onboardingView
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.smooth, value: showTabBar)
    }
}

#Preview {
    AppViewBuilder(
        showTabBar: false,
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
