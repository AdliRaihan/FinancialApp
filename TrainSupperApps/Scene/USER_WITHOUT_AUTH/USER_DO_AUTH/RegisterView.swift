//
//  RegisterView.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 22/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct registerView: View {
    
    @Binding var backState: Bool
    @ObservedObject var keyboardNotification = keyboardObserver()
    
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    @State var emailFail: String?
    @State var passwordFail: String?
    @State var confirmPasswordFail: String?
    
    // Another State
    @State var presentedAlert: Bool = false
    @State var presentedAlertMessage: [String: Any] = [:]
    
    var body: some View {
        content
    }
    
    var content: some View {
        GeometryReader.init { (reader) in
            ZStack {
                VStack.init(alignment: .leading) {
                    // Text
                    FinDefaultText.init("Register", .bold, 22)
                    FinDefaultText.init("Please fill these information.", .regular, 14).padding(EdgeInsets.init(top: 0, leading: 0, bottom: 25, trailing: 0)).foregroundColor(.getPrimaryDimmedColor)
                    
                    self.form
                    
                    // Button
                    Spacer().frame(height: 15)
                    self.buttons
                    
                    if self.presentedAlert == true {
                        FinDefaultText((self.presentedAlertMessage["message"] as? String) ?? "", .regular, 12).foregroundColor(.getRedDarkColor).padding(5)
                    }
                    
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
    
    var buttons: some View {
        VStack {

            Button.init(action: {
                self.createNewAccount()
            }) {
                ZStack {
                    Text("Create new account")
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
                    FinDefaultText.init("Forgot Password?", .regular, 12).frame(alignment: .trailing)
                }
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
            
            // C-Password
            Spacer().frame(height: 15)
            finTextField(editingChanged: { (editingChanged) in
                print(self.password)
            }, onCommit: {
                print(self.password)
            }, valueText: self.$confirmPassword, passwordType: true, validationFailed: self.$confirmPasswordFail, placeholderText: "Confirm Password")
        }
    }
    
    
    private func createNewAccount() {
        
        self.presentedAlert = false
        
        if checkValidation() {
            #if canImport(UIKit)
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            #endif
            Auth.auth().createUser(withEmail: self.email, password: self.password) { (auth, error) in
                if auth != nil {
                    self.presentedAlert = true
                    self.presentedAlertMessage = ["stateToBack":true, "title":"Congratulations.", "message":
                    "You account has successfully created, please login to continue"]
                } else if let _error = error {
                    self.presentedAlert = true
                    self.presentedAlertMessage = ["stateToBack":false, "title":"Register failed.","message": _error.localizedDescription]
                }
            }
        }
    }
    
    private func checkValidation() -> Bool {
        if self.password.isEmpty {
            self.confirmPasswordFail = "Confirm Password cannot be empty."
            
        } else if self.password == self.confirmPassword {
            self.confirmPasswordFail = nil
        } else {
            self.confirmPasswordFail = "Confirm Password not same."
        }
        
        if self.email.isEmpty {
            self.emailFail = "E-mail cannot be empty."
        } else {
            self.emailFail = nil
        }
        
        if self.password.isEmpty {
            self.passwordFail = "Password cannot be empty."
        } else if self.password.count < 6 {
            self.passwordFail = "Pasword length must longer than 6 characters."
        } else {
            self.passwordFail = nil
        }
        
        if (self.emailFail == nil && self.passwordFail == nil && self.confirmPasswordFail == nil) {
            return true
        } else {
            return false
        }
    }
    
}
