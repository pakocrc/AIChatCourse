//
//  View+MaxDynamicTypeSize.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 31/7/25.
//

import SwiftUI

extension View {
    /// Conditionally applies the dynamic type size modifier using a `@ViewBuilder`.
    /// - Parameters:
    ///   - dynamicTypeSize: The `DynamicTypeSize` to verify.
    /// - Returns: A `View` that applies the dynamic type size modifier if enabled; otherwise, returns the original Text view.
    ///
    @ViewBuilder
    func limitMaxDynamicTypeSize(_ dynamicTypeSize: DynamicTypeSize) -> some View {
        if dynamicTypeSize.isAccessibilitySize && dynamicTypeSize == .accessibility5 {
            self.dynamicTypeSize(DynamicTypeSize.accessibility4)
        } else {
            self
        }
    }
}
