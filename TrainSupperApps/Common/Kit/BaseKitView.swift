//
//  BaseKitView.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 22/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import SwiftUI


struct alertView: View {

    // Another State
    @Binding var presentedAlert: Bool
    var okAction: ()->()
    var title: String
    var description: String
    
    var body: some View {
        ZStack {
            Spacer().frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                VStack.init(alignment:.leading) {
                    FinDefaultText
                        .init(title, .bold, 24)
                    Spacer().frame(height: 15)
                    FinDefaultText
                        .init(description, .regular, 14)
                    Spacer().frame(height: 50)
                    Button.init(action: {
                        self.okAction()
                        self.presentedAlert = false
                    }) {
                        ZStack {
                            Text("Understood")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.white)
                                .font(.custom("Helvetica-Bold", size: 14))
                        }
                        .frame(height: 50)
                        .background(Color.getPrimaryColor)
                        .cornerRadius(5)
                    }
                }.padding(25)
            }
            .background(Color.white).padding()
        }
        .cornerRadius(5)
        .shadow(color: Color.getPrimaryColor.opacity((self.presentedAlert) ? 0.1 : 0), radius: 8, x: 0, y: 0)
        .offset(x: 0, y: (self.presentedAlert) ? 0 : screenBounds.height)
        .animation(Animation.easeInOut(duration: 0.5))
    }
}

struct childView<Content>: View where Content: View {
    
    @Binding var backState: Bool
    var content: Content
    
    init(_ content: Content, _ binding: Binding<Bool>) {
        self.content = content
        _backState = binding
    }
    
    var body: some View {
        self.content
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading:
                Button.init(action: {
                    self.backState = false
                }, label: {
                    Image.init("ic_back").resizable().renderingMode(.template)
                        .foregroundColor(.getPrimaryColor).frame(width:25, height: 25)
                })
        )
    }
}
