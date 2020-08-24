//
//  FinTextField.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 30/07/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import SwiftUI

struct finTextField: View {
    
    var editingChanged: (Bool) -> () = { _ in }
    var onCommit: () -> () = {}
    @Binding var valueText: String
    @State var passwordType: Bool
    @Binding var validationFailed: String?
    
    var placeholderText: String
    
    var body: some View {
        VStack.init(alignment: .leading, spacing: 0, content:  {
            VStack.init(alignment: .leading) {
                
                FinDefaultText.init(placeholderText, .bold)
                    .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 0, trailing: 0)).foregroundColor(.getPrimaryDimmedColor)
                
                if self.passwordType {
                    SecureField.init("", text: self.$valueText)
                        .textContentType(.password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                } else {
                    TextField.init("", text: self.$valueText, onEditingChanged: {
                        (changed) in
                        self.editingChanged(true)
                    })
                        .textContentType(.password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
            }
                .padding(.init(top: 10, leading: 10, bottom: 20, trailing: 10)).frame(height: 60, alignment: .leading)
                .overlay(
                    RoundedRectangle.init(cornerRadius: 2.5, style: .circular).stroke((validationFailed == nil) ? Color.getPrimaryDimmedColor : Color.getRedDarkColor, lineWidth: 1)
                )
            
            if validationFailed != nil {
                FinDefaultText(self.validationFailed!, .regular, 12).foregroundColor(.getRedDarkColor).padding(5)
            }
        })
    }
}

struct finPlaceholderLabel: View {
    var state: Bool
    var textOutput: String
    var body: some View {
        ZStack {
            if (state) {
                Text(textOutput)
                    .font(.custom("Helvetica", size: 14))
                    .foregroundColor(.gray)
            } else {
                Text(textOutput).padding(.init(top: -30, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
}
