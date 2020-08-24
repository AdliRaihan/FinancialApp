//
//  NetworkImage.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 05/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import Alamofire

class NetworkImage: ObservableObject {
    
    @Published var image: UIImage?
    
    init(urlString: String) {
        self.getImageFromUrl(urlString)
    }
    
    internal func getImageFromUrl(_ url: String) {
        guard let url = URL.init(string: url) else { return }
        AF.request(url).responseData { (result) in
            if (result.data != nil) {
                self.image = UIImage.init(data: result.data!)
            } else {
                
            }
        }
    }
}
