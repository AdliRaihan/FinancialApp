//
//  NetworkURI.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 05/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import Foundation

let clientId: String = "158e22d2be6cab776308c3250270a395cc2813ca8346c59643b949a4c68ae513"
let secretKey: String = "55c7dc2458c517c02b2797f92f9707f1195e28cf10ab18cb1bf6c238932fc7c3"

let baseURL: String = "https://api.unsplash.com/"

let getPublicPhotos: String = baseURL + "photos/?client_id=" + clientId
let getAuth: String = "https://unsplash.com/oauth/token"
let getPhotos: String = baseURL + "photos/"
