//
//  Message.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 04/10/2022.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}
