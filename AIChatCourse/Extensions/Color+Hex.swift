//
//  Color+Hex.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 8/8/25.
//

import SwiftUI
import UIKit

extension Color {
	
	/// Initialize a SwiftUI Color from a hex string like "#RRGGBB" or "RRGGBBAA"
	init?(hex: String) {
		var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
		hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
		
		var rgb: UInt64 = 0
		guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
		
		let length = hexSanitized.count
		let red, green, blue, alpha: UInt64
		
		switch length {
		case 6: // RGB
			(red, green, blue, alpha) = (rgb >> 16 & 0xFF, rgb >> 8 & 0xFF, rgb & 0xFF, 255)
		case 8: // RGBA
			(red, green, blue, alpha) = (rgb >> 24 & 0xFF, rgb >> 16 & 0xFF, rgb >> 8 & 0xFF, rgb & 0xFF)
		default:
			return nil
		}
		
		self.init(
			.sRGB,
			red: Double(red) / 255,
			green: Double(green) / 255,
			blue: Double(blue) / 255,
			opacity: Double(alpha) / 255
		)
	}
	
	/// Extract a hex string (#RRGGBB) from a Color
	func toHex() -> String? {
		// Convert Color → UIColor → RGBA values
		let uiColor = UIColor(self)
		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var alpha: CGFloat = 0
		
		guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
			return nil
		}
		
		return String(
			format: "#%02lX%02lX%02lX",
			lroundf(Float(red * 255)),
			lroundf(Float(green * 255)),
			lroundf(Float(blue * 255))
		)
	}
}
