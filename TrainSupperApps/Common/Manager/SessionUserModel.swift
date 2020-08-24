//
//  SessionUserModel.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 05/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import RealmSwift
import Alamofire
import ObjectMapper

func getRealm() -> Realm {
    let REALM_SCHEMA_VERSION: UInt64 = 4
    var config = Realm.Configuration()
    config.schemaVersion = REALM_SCHEMA_VERSION
    return try! Realm.init(configuration: config)
}

func revokeRealm() {
    let realm = getRealm()
    try! realm.write {
        realm.deleteAll()
    }
}

class SessionUserModel : Object, Identifiable {
    
    @objc dynamic var loginUID  = "UNSPLASH_ADLI_TRAIN_APPS_SUPERAPPS_UNCHANGED"
    @objc dynamic var authorizationCode: String?
    @objc dynamic var createdAt: Date = Date()
    
    override class func primaryKey() -> String? {
        return "loginUID"
    }
    
    static func ==(_ lhs:SessionUserModel, _ rhs:SessionUserModel) -> Bool {
        return lhs.authorizationCode == rhs.authorizationCode
    }
}

class authModel: Object, Mappable {

    @objc dynamic var loginUID  = "UNSPLASH_ADLI_TRAIN_APPS_SUPERAPPS_UNCHANGED"
    @objc dynamic var access_token: String?
    @objc dynamic var token_type: String?
    @objc dynamic var scope: String?
    @objc dynamic var created_at: String?
    
    required init?(map: Map) {
    }
    
    required init() {
    }
    
    override class func primaryKey() -> String? {
        return "loginUID"
    }
    
    func mapping(map: Map) {
        access_token <- map["access_token"]
        token_type <- map["token_type"]
        scope <- map["scope"]
        created_at <- map["created_at"]
    }
    
}
