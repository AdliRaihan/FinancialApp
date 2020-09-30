//
//  SessionUserRepository.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 05/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import SwiftUI
import Combine
import RealmSwift

class sessionUser: ObservableObject {
    @Published var authorization: String?
}

class authObserver<T>: ObservableObject where T: Object {
    
    private var realm: Realm?
    
    init () {
        self.realm = getRealm()
    }
    
    func createSession(model: T) {
        let obj = realm?.objects(T.self)
        
        if let obj = obj , obj.last != model {
            try! realm?.write {
                realm?.add(model, update: .modified)
            }
        } else {
            realm?.add(model)
        }
    }
    
    
    internal class sessionModifier<S:SessionUserModel, A:authModel>: authObserver {
        
        func getSession() -> String {
            let obj = realm?.objects(S.self)
            return obj?.first?.authorizationCode ?? ""
        }
        
        func getAccessToken() -> A? {
            let obj = realm?.objects(A.self)
            return obj?.first
        }
        
        func createParameter() -> [String:Any] {
            if T.self == S.self {
                return [
                    "client_id":clientId,
                    "client_secret":secretKey,
                    "redirect_uri":"urn:ietf:wg:oauth:2.0:oob",
                    "code":self.getSession(),
                    "grant_type":"authorization_code"
                ]
            } else {
                return [:]
            }
        }
    }
    
    internal class getAccessToken: ObservableObject {
        @Published var authCode: String?
        init() {
            let obj = getRealm().objects(authModel.self)
            authCode = obj.first?.access_token
        }
    }
    
}

extension SessionUserModel {
    convenience init(_ authCode: String) {
        self.init()
        loginUID  = "UNSPLASH_ADLI_TRAIN_APPS_SUPERAPPS_UNCHANGED"
        authorizationCode = authCode
    }
    
    var sendData: Void {
        return authObserver<SessionUserModel>().createSession(model: self)
    }
}

extension authModel {
    var sendData: Void {
        return authObserver<authModel>().createSession(model: self)
    }
}

