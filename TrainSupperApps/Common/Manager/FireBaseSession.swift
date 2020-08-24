//
//  FireBaseSession.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 22/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import Foundation
import RealmSwift
import FirebaseAuth
import SwiftUI

protocol fireBaseImpl {
    func setSession(_ model: FireBaseUserSessionModel)
    func getSession() -> FireBaseUserSessionModel?
    func getAuthorizationMode()
}

class FireBaseUserSessionModel: Object {
    dynamic var uid: String = ""
    dynamic var email: String = ""
    dynamic var refreshToken: String = ""
    dynamic var loginAt: Date = Date()
    dynamic var expiresAt: Date = Date()
}

class fireBaseUserSessionImpl: fireBaseImpl, ObservableObject {
    
    @Published var currentSession: FireBaseUserSessionModel? = nil
    @Published var currentSessionActive: Bool = false
    
    private var handle: AuthStateDidChangeListenerHandle!
    
    init() {
        self.getAuthorizationMode()
    }
    
    func setSession(_ model: FireBaseUserSessionModel) {
        let realm = getRealm()
        do {
            realm.beginWrite()
            realm.add(model)
            try realm.commitWrite()
        }
        catch (let exception) {
            print(exception.localizedDescription)
        }
    }
    
    func getSession() -> FireBaseUserSessionModel? {
        let model = getRealm().objects(FireBaseUserSessionModel.self)
        if let firstUser = model.first {
            return firstUser
        } else {
            return nil
        }
    }
    
    func getAuthorizationMode() {
        self.handle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            withAnimation(.easeInOut) {
                if user != nil {
                    self?.currentSessionActive = true
                } else {
                    self?.currentSessionActive = false
                }
            }
        }
    }
    
    
}
