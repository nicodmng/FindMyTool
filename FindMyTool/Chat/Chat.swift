////
////  Chat.swift
////  FindMyTool
////
////  Created by Nicolas Demange on 17/10/2022.
////
//
//import Foundation
//
//struct Chat {
//    var users: [String]
//    var dictionary: [String: Any] {
//        return ["users": users]
//    }
//}
//
//extension Chat {
//    init?(dictionary: [String:Any]) {
//        guard let chatUsers = dictionary["users"] as? [String] else { return nil }
//        self.init(users: chatUsers)
//    }
//}
