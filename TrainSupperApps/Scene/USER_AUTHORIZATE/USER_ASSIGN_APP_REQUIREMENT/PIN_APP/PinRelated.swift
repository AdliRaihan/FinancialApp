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
    case inputPin
}

struct PinRelated: View {
    @Binding var reRoute: Bool
    @State var pinState: PinCases
    
    var body: some View {
        print(pinState)
        return AnyView(pinScreen(reRouteAvailable: self.$reRoute, pinState: pinState))
    }
}

struct pinScreen: View {
    @Binding var reRouteAvailable: Bool
    @State var pinState: PinCases
    @State var pin: String = ""
    @State var firstPin: String = ""
    @State var pinMatch: Bool = true
    @ObservedObject var manager: profileSectionsWorker = profileSectionsWorker.init(pinModel(), pinCollectionPath)
    var bKeypadLists = ["","0","D"];
    
    var body: some View {
        VStack{
            self.screen
            self.keyPin
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 0)
            VStack {
                HStack {
                    FinDefaultText("Do not insert your", .regular, 12).foregroundColor(.getPrimaryDimmedColor)
                    FinDefaultText("Bank/CreditCard Credentials.", .bold, 12).foregroundColor(.getPrimaryDimmedColor)
                }
                Button.init(action: {
                    
                }) {
                    FinDefaultText("Learn Here For More", .regular, 12).foregroundColor(.blue)
                }
            }.transition(.move(edge: .bottom))
        }.padding(20)
            .animation(Animation.easeInOut(duration: 1))
    }
    
    var screen: some View {
        VStack {
            HStack {
                ZStack {
                    if pinState == PinCases.inputPin {
                        FinDefaultText.init("Input", .bold, 14).padding(EdgeInsets.init(top: 5, leading: 15, bottom: 5, trailing: 15)).lineLimit(nil)
                    } else {
                        FinDefaultText.init("Confirm", .bold, 14).padding(5).lineLimit(nil)
                            .offset(x:  (self.firstPin == "") ? -screenBounds.size.width : 0, y: 0)
                        FinDefaultText.init("Set Up", .bold, 14).padding(5).lineLimit(nil)
                            .offset(x:  (self.firstPin != "") ? -screenBounds.size.width : 0, y: 0)
                    }
                }.transition(.opacity).background(Color.getPrimaryColor).foregroundColor(.white)
                FinDefaultText.init("Your Security Code", .bold, 14).foregroundColor(.getPrimaryColor)
            }
            
            HStack {
                ForEach (0..<6) {
                    index in
                    if (index < self.pin.count) {
                        RoundedRectangle.init(cornerRadius: 5).frame(width:10, height:10).foregroundColor(.getPrimaryColor)
                    } else {
                        RoundedRectangle.init(cornerRadius: 5).frame(width:10, height:10).foregroundColor(Color.getPrimaryDimmedColor)
                    }
                }
            }
            
            if pinMatch == false {
                FinDefaultText.init("Pin did not match!", .bold, 14).foregroundColor(.getRedDarkColor).transition(.opacity)
            }
            
        }.frame(maxHeight: .infinity).animation(.easeInOut(duration: 0.5))
    }
    
    var keyPin: some View {
        
        VStack.init(alignment: .leading) {
            ForEach (0..<4) {
                indexRow in
                HStack.init(alignment: .top) {
                    ForEach (1..<4) {
                        indexCol in
                        if (indexRow == 3) {
                            numPadCustom.init(self.bKeypadLists[indexCol-1]) { (numberString, delete) in
                                if delete, self.pin.count == 6 {
                                    self.pin.removeAll()
                                } else if delete, self.pin.count > 0 {
                                    self.pin.removeLast()
                                }
                                if (self.pin.count <= 5) {
                                    self.pin += numberString
                                }
                                if (self.pin.count > 5){
                                    if self.pinState == PinCases.inputPin {
                                        self.getPin()
                                    } else if self.firstPin != "" {
                                        self.createPin()
                                    } else {
                                        self.firstPin = self.pin
                                        self.pin.removeAll()
                                    }
                                }
                            }
                        } else {
                            numPadCustom.init("\(indexCol + (indexRow * 3))") { (numberString, _) in
                                if (self.pin.count <= 5) {
                                    self.pin += numberString
                                }
                                if (self.pin.count > 5){
                                    if self.pinState == PinCases.inputPin {
                                        self.getPin()
                                    } else if self.firstPin != "" {
                                        self.createPin()
                                    } else {
                                        self.firstPin = self.pin
                                        self.pin.removeAll()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        }.frame(maxHeight: screenBounds.size.width - 25)
            .background(Color.white)
    }
    
    func createPin () {
        autoreleasepool {
            if (self.firstPin != self.pin) {
                self.pinMatch = false
                self.firstPin.removeAll()
                self.pin.removeAll()
            } else {
                do {
                    if let pinInt = Int(self.firstPin) {
                        self.manager.modelOutput.pin = pinInt
                        self.manager.modelOutput.createdAt = Date()
                        self.manager.modelOutput.updatedAt = Date()
                        self.manager.setFirebase()
                        if self.manager.outputSuccess == nil {
                            self.reRouteAvailable = false
                        } else if self.manager.outputSuccess! {
                            self.reRouteAvailable = true
                        }
                    } else {
                        throw NSError.init(domain: "Failed to casts", code: 0, userInfo: [:])
                    }
                } catch (let exception) {
                    print(exception.localizedDescription)
                }
            }
        }
    }
    
    func getPin () {
        self.manager.getFirebase()
        if self.manager.outputSuccess ?? false {
            let mOutput = self.manager.modelOutput
            do {
                if let pinInt = Int(self.pin), pinInt == mOutput.pin {
                    self.reRouteAvailable = true
                } else {
                    self.pin = ""
                    self.pinMatch = false
                    throw NSError.init(domain: "Failed to casts", code: 0, userInfo: [:])
                }
            } catch (let exception) {
                print(exception.localizedDescription)
            }
        }
    }
}

struct numPadCustom: View {
    var Number: String
    var didKeySelected: (String, Bool) -> () = {_, _ in}
    private var size = screenBounds.size
    
    init (_ number: String, _ didKeySelected: @escaping (String, Bool) -> ()) {
        self.Number = number
        self.didKeySelected = didKeySelected
    }
    
    var body: some View {
        Button.init(action: {
            if self.Number == "D" {
                self.didKeySelected("",true)
            } else {
                self.didKeySelected(self.Number,false)
            }
        }) {
            FinDefaultText.init(Number, .bold, 18).foregroundColor(.getPrimaryDimmedColor).frame(maxWidth:.infinity, maxHeight: .infinity)
        }
    }
}
