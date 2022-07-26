//
//  FavoriteToolData.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 17/11/2022.
//

import Foundation
import FirebaseFirestoreSwift

// FavoriteToolData's struct
struct FavoriteToolData: Codable {
    var description: String?
    var docId: String
    var name: String
    var localisation: String
    var price: String
    var imageLink: String?
    var town: String
    var render: String
    var toolId: String?
    var email: String?
}
