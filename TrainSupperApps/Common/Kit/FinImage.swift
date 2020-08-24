//
//  FinImage.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 10/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import SwiftUI

struct finImage: View {
    
    @ObservedObject private var imageLoader: NetworkImage
    
    init(_ urlImage: String?) {
        if let url = urlImage {
            imageLoader = NetworkImage.init(urlString: url)
        } else {
            imageLoader = NetworkImage.init(urlString: "")
        }
    }
    
    var body: some View {
        if let image = imageLoader.image {
            print(image.size)
            return AnyView(Image.init(uiImage: image).resizable())
        } else {
            return AnyView(
                Text("Loading . . .")
            )
        }
    }
}
