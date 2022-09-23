//
//  PostalCode.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 02/09/2022.
//

import Foundation

struct TownData: Decodable {
    let codePostal: String
    let codeCommune: String
    let nomCommune: String
    let libelleAcheminement: String
}
