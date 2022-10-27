//
//  MessageManager.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 21/10/2022.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

class MessageManager: ObservableObject {
    
    var messages: [Message] = []
    let db = Firestore.firestore()
    
    init() {
        getMessages()
    }
    
    func getMessages() {
        db.collection("chat").addSnapshotListener { querySnap, error in
            guard let documents = querySnap?.documents else {
                print("Error \(String(describing: error))")
                return
            }
            self.messages = documents.compactMap { document -> Message? in
                do {
                    print("-------------__>\(document)")
                    return try document.data(as: Message.self)
                    
                } catch {
                    print("Error decoding \(error)")
                    return nil
                }
                
            }
        }
    }
    
}
