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
    let postalCode: String

    init(name: String, price: String, town: String, postalCode: String) {
        self.name = name
        self.price = price
        self.town = town
        self.postalCode = postalCode

    }
}
