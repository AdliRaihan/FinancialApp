//
//  Network.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 05/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import Alamofire
import ObjectMapper

enum networkCallbacks<T:Mappable> {
    case success(T)
    case successWithArray([T])
    case failed(String)
}

class network<T: Mappable>{
    
    
    func commitHandshake(url: String,
                         method: HTTPMethod,
                         parameter: Dictionary<String, Any>?,
                         completion: @escaping (networkCallbacks<T>) -> Void)
    {
        
        guard let url = URL.init(string: url) else { return }
        
        if let param = parameter {
            print("Parameter \(param)")
        }
        
        _ = AF.request(url, method: method, parameters: parameter, headers: nil).responseJSON { (response) in
            let jsonResponseArray = response.value as? [[String:Any]]
            let jsonResponse = response.value as? [String:Any]
            
            // =============
            // If resposne is json array
            // =============
            if (jsonResponseArray != nil) {
                self.displayJsonArray(jsonResponseArray!)
                completion(
                    .successWithArray(
                        Mapper<T>().mapArray(JSONArray: jsonResponseArray!)
                    )
                )
            }
            
            // =============
            // If response is json
            // =============
            else if (jsonResponse != nil) {
                self.displayJson(jsonResponse!)
                completion(
                    .success(
                        Mapper<T>().map(JSON: jsonResponse!)!
                    )
                )
            }
            
            // =============
            // If response cant identify response
            // =============
            else {
                completion(.failed("Error Not Found"))
            }
            
        }
        
    }

    private func displayJson(_ dict: [String:Any]) {
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let jsonString = NSString.init(data: jsonData, encoding: String.Encoding.utf8.rawValue)
        if let jsonPretty = jsonString {
            print("Response Pretty Printed : \(jsonPretty)")
            
        }
    }
    
    private func displayJsonArray(_ dict: [[String:Any]]) {
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let jsonString = NSString.init(data: jsonData, encoding: String.Encoding.utf8.rawValue)
        if let jsonPretty = jsonString {
            print("Response Pretty Printed : \(jsonPretty)")
            
        }
    }
    
}
