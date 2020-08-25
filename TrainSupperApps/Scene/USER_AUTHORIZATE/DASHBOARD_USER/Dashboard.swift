//
//  Dashboard.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 24/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct dashboardView: View {
    
    // Business Logic
    @ObservedObject var checkPin: profileSectionsWorker = profileSectionsWorker.init(pinModel(), pinCollectionPath)
    
    // Main
    var body: some View {
        ZStack {
            if checkPin.outputSuccess {
                self.contentLayout
            } else {
                PinRelated.init(.setupPin)
            }
        }.onAppear {
            self.checkPin.getFirebase()
        }
    }
    
    private var contentLayout: some View {
        VStack {
            self.contentTopLayer
            VStack {
                Text("Mid")
            }.frame(maxHeight: .infinity)
            VStack {
                Text("Bottom")
            }
        }
    }
    
    private var contentTopLayer: some View {
        VStack.init(alignment:.leading, spacing: 0) {
            HStack {
                FinDefaultText("Hello,", .regular, 22)
                FinDefaultText("User !", .bold, 20).frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack {
                FinDefaultText("You haven't setup your profile, click here to start your progress", .thin, 14).foregroundColor(.getPrimaryDimmedColor)
            }
            
        }.frame(height:75).padding()
    }
}

class dashboardViewBusiness: ObservableObject {
    
    // final
    final let wallet: Int = 100000
    @Published var currentWallet: Int = 0
    
    func classCalculateTotalWallet() {
    }
}
