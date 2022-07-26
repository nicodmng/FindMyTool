//
//  ToolsResult.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 16/09/2022.
//

import Foundation

// Tool's struct
struct Tool {
    let name: String
    let price: String
    let town: String
    let imageLink: String?
    let postalCode: String
    let description: String?
    let toolId: String?
    let docId: String?
    let email: String?

    init(name: String, price: String, town: String, imageLink: String?, postalCode: String, description: String?, toolId: String, docId: String, email: String) {
        self.name = name
        self.price = price
        self.town = town
        self.imageLink = imageLink
        self.postalCode = postalCode
        self.description = description
        self.toolId = toolId
        self.docId = docId
        self.email = email
    }
    
}

