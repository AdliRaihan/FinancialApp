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
    @State var paddingTop: CGFloat = 70
    @State var authorize:Bool = false
    
    @State var dashboardInLoad: Bool = false
    
    @State private var showDetails = false
    
    init () {
    }
    
    var body: some View {
        Group {
            ZStack {
                if Auth.auth().currentUser?.refreshToken != nil {
                    AppRootWithOnAuth()
                } else {
                    LandingView_main().transition(.slide).zIndex(1)
                }
            }
        }
    }
}

class appRootHostring<Content>: UIHostingController<Content> where Content: View {
    
    override init(rootView: Content) {
        super.init(rootView: rootView)
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout(_:)), name: .AuthStateDidChange, object: nil)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @objc func didLogout(_ sender:Notification) {
        if self.rootView is AppRoot {
            print("App Root Brother")
//            self.rootView = AppRootWithOnAuth() as! Content
        }
        print(sender)
    }
    
}
