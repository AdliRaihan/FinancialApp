//
//  AppRoot.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 12/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import SwiftUI
import FirebaseAuth

let screenBounds = UIScreen.main.bounds

struct AppRoot: View {
    
    @EnvironmentObject var session: sessionUser
    @ObservedObject var modelAuth = fireBaseUserSessionImpl()
    @State var paddingTop: CGFloat = 70
    @State var authorize:Bool = false
    
    @State var dashboardInLoad: Bool = false
    
    @State private var showDetails = false
    
    init () {
        
    }
    
    var body: some View {
        Group {
            ZStack {
                if self.modelAuth.currentSessionActive {
                    dashboardView()
                        .transition(.opacity)
                } else {
                    LandingView_main().environmentObject(session).transition(.slide).zIndex(1)
                }
            }
        }
    }
    
}
