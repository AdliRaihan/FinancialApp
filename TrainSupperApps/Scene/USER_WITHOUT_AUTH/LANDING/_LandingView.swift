//
//  _LandingView.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 18/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import SwiftUI
import FirebaseAuth

// MARK: Main Landing
struct LandingView_main: View {
    
    var body: some View {
        LandingView_content()
    }
    
}

// MARK: Main Content
private struct LandingView_content: View {
    
    @EnvironmentObject var session: sessionUser
    @State var buttonLoginToExisting: Bool = false
    @State var buttonCreateNewAccount: Bool = false
    @State var actionSheetOpen: Bool = false
    
    var body: some View {
        NavigationView.init(content: {
            VStack {
                NavigationLink.init(destination: childView.init(registerView(backState: self.$buttonCreateNewAccount), self.$buttonCreateNewAccount), isActive: self.$buttonCreateNewAccount) {
                    EmptyView()
                }
                
                NavigationLink.init(destination: childView.init(loginView(backState: self.$buttonLoginToExisting), self.$buttonLoginToExisting), isActive: self.$buttonLoginToExisting) {
                    EmptyView()
                }
                // * Display View
                self.contextLayoutView
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading:
                HStack {
                    FinDefaultText.init("England, UK", .regular, 12).foregroundColor(.getPrimaryDimmedColor)
                    Button.init(action: {
                        self.actionSheetOpen = true
                    }) {
                        Image.init("ic_drop_down").resizable().renderingMode(.template).frame(width: 12, height: 12, alignment: .center).clipped().foregroundColor(.getPrimaryDimmedColor)
                    }
                }
            )
                
        })
    }
    
    // MARK: Content - Layout
    private var contextLayoutView: some View {
        ZStack {
            VStack {
                // * Mid View
                contextMidView.padding(EdgeInsets.init(top: 0, leading: 0, bottom: 20, trailing: 0))
                
                // * Bottom View
                contextBottomView
            }.padding(EdgeInsets.init(top: 0, leading: 20, bottom: 20, trailing: 20))
            
            VStack {
                VStack.init(alignment:.leading) {
                    FinDefaultText
                        .init("Sorry.", .bold, 24)
                    Spacer().frame(height: 15)
                    FinDefaultText
                        .init("This feature is not available in this version. Default language will be set to english, UK at the moment.", .regular, 14)
                    Spacer().frame(height: 50)
                    Button.init(action: {
                        self.actionSheetOpen = false
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
            .cornerRadius(5)
            .shadow(color: Color.getPrimaryColor.opacity((self.actionSheetOpen) ? 0.1 : 0), radius: 8, x: 0, y: 0)
            .offset(x: 0, y: (self.actionSheetOpen) ? 0 : screenBounds.height)
            .animation(.spring(response: 1.0, dampingFraction: 0.5, blendDuration: 0.25))
        }
    }
    
    // MARK: Content - MidView
    private var contextMidView: some View {
        VStack {
            HStack {
                FinDefaultText
                    .init("SwiftUISample", .bold, 22)
                    .foregroundColor(.getPrimaryColor)
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            
            FinDefaultText
                .init("Please login to continue.", .regular, 14)
                .foregroundColor(.getPrimaryDimmedColor)
                .frame(maxWidth: .infinity,alignment: .leading)
        }
        .background(Color.white)
    }
    
    private var contextBottomView: some View {
        VStack {
            Button.init(action: {
                self.buttonCreateNewAccount = true
            }) {
                ZStack {
                    Text("Create new account")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .font(.custom("Helvetica-Bold", size: 14))
                }
                .padding(15)
            }
            .background(Color.getPrimaryColor)
            .shadow(color: .getPrimaryColor, radius: 8, x: 0, y: 0)
            .cornerRadius(2)
            
            Button.init(action: {
                
                self.buttonLoginToExisting = !self.buttonLoginToExisting
            }) {
                ZStack {
                    Text("Login to existing account")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.getPrimaryDimmedColor)
                        .font(.custom("Helvetica-Bold", size: 14))
                }
                .padding(15)
            }
        }
    }
    
}
