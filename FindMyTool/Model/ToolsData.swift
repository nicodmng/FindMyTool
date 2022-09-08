//
//  Tools.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 29/07/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Tools: Codable {
    var name: String
    var price: String
    var localisation: String
    var town: String
    
    enum CodingKeys: String, CodingKey {
            case name
            case price
            case localisation
            case town
        }
}
