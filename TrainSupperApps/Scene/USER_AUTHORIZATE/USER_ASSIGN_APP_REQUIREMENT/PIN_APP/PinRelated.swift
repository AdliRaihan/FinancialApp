//
//  SetupPin.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 25/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import SwiftUI

enum PinCases {
    case forgotPin
    case changePin
    case setupPin
}

struct PinRelated: View {
    @State var pinState: PinCases = .setupPin
    init (_ pinState: PinCases) {
        self.pinState = pinState
    }
    
    var body: some View {
        print(pinState)
        switch pinState {
        case .forgotPin:
            return AnyView(forgotPin())
            
        case .changePin:
            return AnyView(forgotPin())
            
        case .setupPin:
            return AnyView(forgotPin())
        }
    }
}

fileprivate struct forgotPin: View {
    var body: some View {
        VStack {
            Text("Please Setup your PIN.")
            pinScreen().clipped()
        }.clipped()
    }
}

fileprivate struct pinScreen: View {
    
    @State var pin: String = ""
    
    var body: some View {
        VStack{
            self.screen
            self.keyPin
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 0)
            Spacer().frame(height:50)
        }
    }
    
    var screen: some View {
        HStack(alignment:.bottom) {
            ForEach (0..<5) {
                index in
                Text("\(index)")
            }
        }.frame(maxHeight: 200)
    }
    
    var keyPin: some View {
        GeometryReader.init { (reader) in
            VStack.init(alignment: .leading) {
                ForEach (0..<3) {
                    indexRow in
                    HStack.init(alignment: .top) {
                        ForEach (1..<4) {
                            indexCol in
                            keyPad.init(Number: "\(indexCol + (indexRow * 3))", size: reader.size, didKeySelected: {
                                value, deleted in
                                if (deleted == true) {
                                    
                                } else {
                                    self.pin += value
                                }
                                print(self.pin)
                            })
                        }
                    }
                }
                
                HStack.init(alignment: .top) {
                    keyPad.init(Number: "", size: reader.size)
                    keyPad.init(Number: "0", size: reader.size)
                    keyPad.init(Number: "DEL", size: reader.size)
                }
                
            }.frame(maxHeight: .infinity)
                .background(Color.white)
        }
    }
    
    struct keyPad: View {
        var Number: String
        var size: CGSize
        var didKeySelected: (String, Bool) -> () = {_, _ in}
        var body: some View {
            Button.init(action: {
                if self.Number == "DEL" {
                    self.didKeySelected("",true)
                } else {
                    self.didKeySelected(self.Number,false)
                }
            }) {
                FinDefaultText.init(Number, .bold, 18).foregroundColor(.getPrimaryDimmedColor).frame(width:size.height/4,height:size.height/4)
            }
        }
    }
}

