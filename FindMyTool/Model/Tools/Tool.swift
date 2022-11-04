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
    let imageLink: String?
    let postalCode: String
    let description: String?

    init(name: String, price: String, town: String, imageLink: String?, postalCode: String, description: String?) {
        self.name = name
        self.price = price
        self.town = town
        self.imageLink = imageLink
        self.postalCode = postalCode
        self.description = description
    }
    
    init(entity: ToolEntity) {
        self.name = entity.name ?? ""
        self.price = entity.price ?? ""
        self.town = entity.town ?? ""
        self.postalCode = entity.postalCode ?? ""
        self.description = entity.description
        self.imageLink = entity.image ?? ""
    }
}
