//
//  FinDefaultText.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 14/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import SwiftUI

enum FontType {
    case bold
    case light
    case regular
    case thin
}

struct FinDefaultText: View {
    
    private var type: FontType
    private var output: String
    private var fontSize: CGFloat
    
    var currentFontType: Font {
        switch type {
        case .bold:
            return Font.custom("HelveticaNeue-Bold", size: fontSize)
        case .light:
            return Font.custom("HelveticaNeue-Light", size: fontSize)
        case .regular:
            return Font.custom("HelveticaNeue", size: fontSize)
        case .thin:
            return Font.custom("HelveticaNeue-Thin", size: fontSize)
        }
    }
    
    var currentTextView: Text {
        return Text.init(output)
    }
    
    init(_ withText: String, _ fontType: FontType, _ fontSize: CGFloat = 12) {
        // font type settings
        self.output = withText
        self.type = fontType
        self.fontSize = fontSize
    }
    
    var body: some View {
        return currentTextView.font(self.currentFontType)
    }
    
    private func manualSize(_ size:CGFloat) {
    }
    
}
