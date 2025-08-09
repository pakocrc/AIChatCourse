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
}
