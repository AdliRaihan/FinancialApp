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
    @ObservedObject var dashboardBusiness: dashboardViewBusiness = .init()
    
    // Main
    var body: some View {
        self.contentLayout
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
            VStack {
                Button.init("Mencoba test") {
                    self.dashboardBusiness.debugPushToFirebase()
                }
                Button.init("Force Logout test") {
                    self.dashboardBusiness.debugToLogout()
                }
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
    
    func debugPushToFirebase() {
//        let uid: String? = fireBaseUserSessionImpl().getSession()?.uid
//        let db: Firestore! = Firestore.firestore()
//        let currentUser: User? = Auth.auth().currentUser
//        var userModel: profileSections = profileSections()
//
//        userModel.age = 21
//        userModel.experience_in_current_work = 2
//        userModel.salary_per_months = 4500000
//        userModel.salary_per_year = 60000000
//        userModel.job = "iOS Engineer"
//
//        db.collection("profile_sections").document("TEST").setData(userModel.toJSON()) {
//            err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
        
        
        guard currentUser != nil else { return }
    }
    
    func debugToLogout() {
        do {
            try Auth.auth().signOut()
        } catch (let Exception) {
            print(Exception.localizedDescription)
        }
    }
}
