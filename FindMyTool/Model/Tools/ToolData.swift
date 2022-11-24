//
//  Tools.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 29/07/2022.
//

import Foundation
import FirebaseFirestoreSwift

// ToolData's struct
struct ToolData: Codable {
    var description: String?
    var docId: String
    var name: String
    var postalCode: String
    var price: String
    var render: String?
    var lender: String
    var isAvailable: Bool?
    var imageLink: String?
    var imagePath: String?
    var town: String
    var toolId: String?
    var email: String?
}
