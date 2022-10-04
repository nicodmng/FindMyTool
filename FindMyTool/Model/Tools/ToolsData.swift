//
//  Tools.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 29/07/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct ToolData: Codable {
    
    var docId: String
    var name: String
    var postalCode: String
    var price: String
    var town: String
    var render: String?
    var lender: String
    var isAvailable: Bool?
    var image: URL?
}
