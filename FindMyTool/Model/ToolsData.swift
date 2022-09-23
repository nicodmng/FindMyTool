//
//  Tools.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 29/07/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Tool: Codable {
    
    @DocumentID var docId: String? = UUID().uuidString
    var name: String
    var localisation: String
    var price: String
    var town: String
    var render: String?
    var lender: String
    var isAvailable: Bool?
    
    enum CodingKeys: String, CodingKey {
        case name
        case localisation
        case price
        case town
        case render
        case lender
        case isAvailable
    }
}
