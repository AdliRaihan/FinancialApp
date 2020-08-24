//
//  Color+Extension.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 05/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import SwiftUI

extension Color {
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    static var getPrimaryColor: Color {
        //        return UIColor.init(rgb: 0x121212)
        return Color.init(hex: "#121212")
    }
    
    static var getPrimaryDimmedColor: Color {
        //        return UIColor.init(rgb: 0x363636)
        return Color.init(hex: "#a8a8a8")
    }
    
    static var getLightWhiteColor: Color {
        //        return UIColor.init(rgb: 0xf5f5f5)
        return Color.init(hex: "#121212")
    }
    
    static var getDarkWhiteColor: Color {
        //        return UIColor.init(rgb: 0xa8a8a8)
        return Color.init(hex: "#363636")
    }
    
    static var getRedDarkColor: Color {
        return Color.init(hex: "#b71c1c")
    }
}
