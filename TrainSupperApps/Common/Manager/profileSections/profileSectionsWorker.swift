//
//  profileSectionsWorker.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 24/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import Foundation
import ObjectMapper

protocol profileSectionBusinessLogic {
    associatedtype authorized
    func castsAuthorized() -> authorized
}

struct tokenType<PSB: profileSectionBusinessLogic> {
    private var token: PSB
    init(_ anyToken: PSB) {
        self.token = anyToken
    }
    func casts() -> PSB.authorized {
        return self.token.castsAuthorized()
    }
}

struct profileSectionAuthorized: profileSectionBusinessLogic {
    func castsAuthorized() -> profileSectionAuthorized {
        return self
    }
}

struct profileSectionsC<T>: Mappable where T:profileSectionBusinessLogic {
    var age: Int!
    var job: String!
    var experience_in_current_work: Float!
    var name: String!
    var salary_per_months: Int!
    var salary_per_year: Int!
    var uid: Int!
    var authorized: tokenType<T>!
    
    init?(map: Map) {
    }
    
    init() {
        
    }
    
    mutating func mapping(map: Map) {
        age <- map["age"]
        job <- map["job"]
        experience_in_current_work <- map["experience_in_current_work"]
        name <- map["name"]
        salary_per_months <- map["salary_per_months"]
        salary_per_year <- map["salary_per_year"]
        uid <- map["uid"]
    }
    
}

class profileSectionsWorker {
    
    func setFirebaseUserProfile(_ model: profileSections) {
        let model = profileSectionsC<profileSectionAuthorized>()
        
    }
    
}
