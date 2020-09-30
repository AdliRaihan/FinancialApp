//
//  AppRootAuthorizated.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 27/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import SwiftUI

struct AppRootWithOnAuth: View {
    
    // Business Logic
    @ObservedObject var checkPin: profileSectionsWorker = profileSectionsWorker.init(pinModel(), pinCollectionPath)
    @State var pinAuthorizate: Bool = false
    
    var body: some View {
        ZStack {
            if pinAuthorizate {
                dashboardView().transition(.opacity)
            } else if checkPin.outputSuccess == nil {
                EmptyView()
            } else if checkPin.outputSuccess! {
                PinRelated.init(reRoute: self.$pinAuthorizate, pinState: PinCases.inputPin).transition(.slide)
            } else {
                PinRelated.init(reRoute: self.$pinAuthorizate, pinState: PinCases.setupPin).transition(.slide)
            }
        }.onAppear {
            self.checkPin.getFirebase()
        }.animation(Animation.easeInOut(duration: 1))
    }
}
