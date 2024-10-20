//
//  Image.swift
//  PetsDogApp
//
//  Created by Eze Chidera Paschal on 24/09/2024.
//

import SwiftUI

struct ImageModel: Identifiable {
    var id: UUID = .init()
    var image: String
}


var images: [ImageModel] = (1...5).compactMap({ ImageModel(image: "shop\($0)") })
