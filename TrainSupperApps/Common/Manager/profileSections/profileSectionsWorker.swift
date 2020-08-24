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
    associatedtype personalInformation
    func sendToFireBase(_ M:Mappable) -> personalInformation
}

struct tokenType<PSB: profileSectionBusinessLogic, M:Mappable> {
    private var token: PSB
    private var model: M
    init(_ anyToken: PSB, _ anyModel:M) {
        self.token = anyToken
        self.model = anyModel
    }
    func sendToFireBase() -> PSB.personalInformation {
        return self.token.sendToFireBase(self.model)
    }
}

struct profileSectionPersonalInformation: profileSectionBusinessLogic {
    func sendToFireBase(_ M:Mappable) -> profileSectionPersonalInformation {
        print("send to firebase Personal")
        return self
    }
    
}

struct profileSectionWorkInformation: profileSectionBusinessLogic {
    func sendToFireBase(_ M:Mappable) -> profileSectionWorkInformation {
        print("send to firebase Work")
        return self
    }
}

struct profileSectionsObject<T:profileSectionBusinessLogic, M:Mappable> {
    let Model: M
    let Worker: T
    func startCommit() {
        _ = self.Worker.sendToFireBase(Model)
    }
}

class profileSectionsWorker {
    
    func setFirebaseUserProfile(_ model: profileSections) {
        let model = profileSectionsObject.init(Model: model, Worker: profileSectionPersonalInformation())
        model.startCommit()
    }
    
}
