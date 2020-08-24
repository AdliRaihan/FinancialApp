//
//  profileSectionsWorker.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 24/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import SwiftUI
import Foundation
import ObjectMapper
import FirebaseFirestore
import FirebaseAuth

// sementara
var profileSectionCollectionPath = "profile_sections"
var currentEmail = {
    return Auth.auth().currentUser?.email ?? ""
}

enum profileSectionBussinessCase{
    case success
    case failed(String)
}

protocol profileSectionBusinessLogic {
    associatedtype personalInformation
    var businessCase: ((profileSectionBussinessCase) -> Void) { get }
    func sendToFireBase(_ M:Mappable) -> personalInformation
}

private struct tokenType<PSB: profileSectionBusinessLogic, M:Mappable> {
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

private class profileSectionPersonalInformation: profileSectionBusinessLogic {
    var businessCase: ((profileSectionBussinessCase) -> Void) = {_ in}
    func sendToFireBase(_ M:Mappable) -> profileSectionPersonalInformation {
        Firestore.firestore().collection(profileSectionCollectionPath).document(currentEmail()).setData(M.toJSON()) {
            err in
            if err == nil { self.businessCase(.success) }
            else { self.businessCase(.failed(err!.localizedDescription))}
        }
        return self
    }
}

private class profileSectionWorkInformation: profileSectionBusinessLogic {
    var businessCase: ((profileSectionBussinessCase) -> Void)  = {_ in}
    func sendToFireBase(_ M:Mappable) -> profileSectionWorkInformation {
        Firestore.firestore().collection(profileSectionCollectionPath).document(currentEmail()).setData(M.toJSON()) {
            err in
            if err == nil {
                self.businessCase(.success)
            }
            else {
                self.businessCase(.failed(err!.localizedDescription))
            }
        }
        
        return self
    }
}

private struct profileSectionsObject<T:profileSectionBusinessLogic, M:Mappable> {
    let Worker: tokenType<T,M>
    func startCommit() -> T? {
        if let tStrong = self.Worker.sendToFireBase() as? T {
            return tStrong
        } else {
            return nil
        }
    }
}

class profileSectionsWorker {
    func setFirebaseUserProfile(_ model: profileSections) {
        profileSectionsObject.init(Worker: tokenType.init(profileSectionPersonalInformation.init(), model)).startCommit()?.businessCase = {
            result in
            print(result)
        }
    }
}
