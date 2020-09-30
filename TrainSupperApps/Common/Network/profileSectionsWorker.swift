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
var currentEmail = {
    return Auth.auth().currentUser?.email ?? ""
}
var failedConvertGenerics = {
    return ["message":"Operation couldn't be completed, please try again later"]
}

fileprivate enum profileSectionBussinessCase {
    case success
    case successWithJSON(Mappable?)
    case failed(String)
    
    func handleResults<T>() -> T? where T: Mappable {
        guard case .successWithJSON(let value) = self else {
            return nil
        }
        return value as? T
    }
}

fileprivate protocol profileSectionBusinessLogic {
    associatedtype personalInformation
    var businessCase: ((profileSectionBussinessCase) -> Void) { get }
    func sendToFireBase(_ M:Mappable, _ Path: String) -> personalInformation
}

private struct tokenType<PSB: profileSectionBusinessLogic, M:Mappable> {
    private var token: PSB
    private var model: M
    private var path: String
    init(_ anyToken: PSB, _ anyModel:M, _ path: String) {
        self.token = anyToken
        self.model = anyModel
        self.path = path
    }
    func sendToFireBase() -> PSB.personalInformation {
        return self.token.sendToFireBase(self.model, self.path)
    }
}

private class profileSectionPersonalInformation: profileSectionBusinessLogic {
    var businessCase: ((profileSectionBussinessCase) -> Void) = {_ in}
    func sendToFireBase(_ M:Mappable, _ Path: String) -> profileSectionPersonalInformation {
        Firestore.firestore().collection(Path).document(currentEmail()).setData(M.toJSON()) {
            err in
            if err == nil { self.businessCase(.success) }
            else { self.businessCase(.failed(err!.localizedDescription))}
        }
        return self
    }
}

private class profileSectionGetPersonalInformation<R:Mappable>: profileSectionBusinessLogic {
    var businessCase: ((profileSectionBussinessCase) -> Void) = {_ in}
    func sendToFireBase(_ M: Mappable, _ Path: String) -> profileSectionGetPersonalInformation {
        Firestore.firestore().collection(Path).document(currentEmail()).getDocument { (snapshot, error) in
            if let docs = snapshot, docs.exists, let json = docs.data() {
                let Model = Mapper<R>.init()
                self.businessCase(.successWithJSON(Model.map(JSON: json)))
            } else if let error = error {
                self.businessCase(.failed(error.localizedDescription))
            } else {
                self.businessCase(.failed("Information Not Found!"))
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

class profileSectionsWorker<T>: ObservableObject where T:Mappable {
    
    // MARK: Variables
    @Published var modelOutput: T
    @Published var outputSuccess: Bool? = nil
    private let modelInput: T
    private let path: String
    
    init(_ inOut: T, _ command: String) {
        self.modelInput = inOut
        self.modelOutput = inOut
        self.path = command
    }
    
    // MARK: Commands
    fileprivate lazy var getPersonalInformation = { return tokenType.init(profileSectionGetPersonalInformation<T>(), self.modelOutput, self.path) }
    fileprivate lazy var setPersonalInformation = { return tokenType.init(profileSectionPersonalInformation(), self.modelOutput, self.path) }
    
    // MARK: Get Fire Base Profile Information
    func getFirebase() {
        profileSectionsObject.init(Worker: getPersonalInformation()).startCommit()?.businessCase = {
            completion in
            do {
                let modelWeak: T? = completion.handleResults()
                if let modelStrong = modelWeak {
                    self.modelOutput = modelStrong
                    self.outputSuccess = true
                } else {
                    self.outputSuccess = false
                    throw NSError.init(domain: "Failed", code: 0, userInfo: [:])
                }
            } catch (let Exception) {
                self.outputSuccess = false
                print(Exception.localizedDescription)
            }
            
        }
    }
    
    // MARK: Set Fire Base Profile Information
    func setFirebase() {
        profileSectionsObject.init(Worker: setPersonalInformation()).startCommit()?.businessCase = {
            result in
            print(result)
        }
    }
    
}

struct failedModel {
    var errorCode: String?
    var message: String
}


