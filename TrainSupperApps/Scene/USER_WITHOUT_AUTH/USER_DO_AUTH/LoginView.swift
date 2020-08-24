//
//  LoginView.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 22/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import SwiftUI
import Firebase

struct loginView: View {
    
    @Binding var backState: Bool
    @ObservedObject var keyboardNotification = keyboardObserver()
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State var emailFail: String?
    @State var passwordFail: String?
    
    var body: some View {
        GeometryReader.init { (reader) in
            ZStack {
                VStack.init(alignment: .leading) {
                    // Text
                    FinDefaultText.init("Sign In", .bold, 22)
                    FinDefaultText.init("Welcome Back.", .regular, 14).padding(EdgeInsets.init(top: 0, leading: 0, bottom: 25, trailing: 0)).foregroundColor(.getPrimaryDimmedColor)
                    
                    self.form
                    
                    // Button
                    Spacer().frame(height: 15)
                    self.buttons
                    
                }.padding()
            }
            .offset(x: self.keyboardNotification.rectKeyboard.origin.x, y: self.keyboardNotification.rectKeyboard.origin.y)
            .animation(Animation.easeInOut(duration: 0.75))
            .onAppear {
                self.keyboardNotification.createObservable(reader.size)
            }
            .onDisappear {
                self.keyboardNotification.removeObservable()
            }
        }
    }
    
    var form: some View {
        VStack {
            // Email
            finTextField(editingChanged: { (editingChanged) in
                print(self.email)
            }, onCommit: {
                
            }, valueText: self.$email, passwordType: false, validationFailed: self.$emailFail ,placeholderText: "E-mail")
            
            // Password
            Spacer().frame(height: 15)
            finTextField(editingChanged: { (editingChanged) in
                print(self.password)
            }, onCommit: {
                print(self.password)
            }, valueText: self.$password, passwordType: true, validationFailed: self.$passwordFail ,placeholderText: "Password")
        }
    }
    
    var buttons: some View {
        VStack {
            Button.init(action: {
                self.doLogin()
            }) {
                ZStack {
                    Text("Sign in")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .font(.custom("Helvetica-Bold", size: 14))
                }
                .padding(15)
            }.background(Color.getPrimaryColor).shadow(color: .getPrimaryColor, radius: 8, x: 0, y: 0).cornerRadius(2)
            
            Spacer().frame(height:15)
            
            Button.init(action: {
                
            }) {
                VStack.init(alignment: .trailing, spacing: 0) {
                    FinDefaultText.init("Forgot Password?", .regular, 12).frame(maxWidth: .infinity,alignment: .trailing)
                }
            }
        }
    }
    
    private func doLogin() {
        Auth.auth().signIn(withEmail: self.email, password: self.password) { (auth, error) in
            if let _auth = auth {
                autoreleasepool {
                    let model: FireBaseUserSessionModel = FireBaseUserSessionModel()
                    if let _email = _auth.user.email {
                        model.email = _email
                    }
                    if let _refreshToken = _auth.user.refreshToken {
                        model.refreshToken = _refreshToken
                    }
                    model.uid =  _auth.user.uid
                    fireBaseUserSessionImpl().setSession(model)
                }
                print(_auth.user.uid)
            } else if let _error = error {
                print(_error.localizedDescription)
            }
        }
    }
    
}


