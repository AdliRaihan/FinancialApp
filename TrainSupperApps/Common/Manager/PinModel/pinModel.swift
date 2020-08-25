//
//  pinModel.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 25/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import ObjectMapper

struct pinModel: Mappable {
    
    var pin: Int!
    var createdAt: Date?
    var updatedAt: Date!
    
    init?(map: Map) {
    }
    
    init() {
    }
    
    mutating func mapping(map: Map) {
        pin <- map["pin"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
    }
    
}
