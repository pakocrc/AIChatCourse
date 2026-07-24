//
//  Bundle+Versions.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 8/8/25.
//

import Foundation

extension Bundle {
	var appVersion: String {
		return infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
	}
	
	var buildNumber: String {
		return infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
	}

    var appName: String {
        // Prefer the display name if available, otherwise fall back to bundle name
        if let displayName = infoDictionary?["CFBundleDisplayName"] as? String, !displayName.isEmpty {
            return displayName
        }
        if let name = infoDictionary?["CFBundleName"] as? String, !name.isEmpty {
            return name
        }
        return "Unknown"
    }
}
