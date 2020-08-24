//
//  File.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 24/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import ObjectMapper

struct profileSections: Mappable {
    var age: Int!
    var job: String!
    var experience_in_current_work: Float!
    var name: String!
    var salary_per_months: Int!
    var salary_per_year: Int!
    var uid: Int!
    
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
