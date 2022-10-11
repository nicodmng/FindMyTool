//
//  ToolsResult.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 16/09/2022.
//

import Foundation

struct Tool {
    let name: String
    let price: String
    let town: String
    let imageRef: String?
    let postalCode: String
    let description: String?

    init(name: String, price: String, town: String, imageRef: String?, postalCode: String, description: String?) {
        self.name = name
        self.price = price
        self.town = town
        self.imageRef = imageRef
        self.postalCode = postalCode
        self.description = description
    }
}
