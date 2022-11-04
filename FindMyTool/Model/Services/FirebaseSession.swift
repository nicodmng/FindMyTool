//
//  FirebaseSession.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 04/11/2022.
//

import Foundation

import FirebaseCore
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

protocol FirebaseSession {
    
    func addToolInDatabase(name: String, localisation: String, description: String, price: String, town: String, imageLink: String, imagePath: String, render: String, lender: String?, isAvailable: Bool, completion: ((Error?) -> Void)? )
}

final class DatabaseSession: FirebaseSession {
    func addToolInDatabase(name: String, localisation: String, description: String, price: String, town: String, imageLink: String, imagePath: String, render: String, lender: String?, isAvailable: Bool, completion: ((Error?) -> Void)?) {
        Firestore.firestore().collection("tools").addDocument(data: [
            "name": name,
            "localisation": localisation,
            "description": description,
            "price": price,
            "town": town,
            "imageLink": imageLink,
            "imagePath": imagePath,
            "render": render,
            "lender": lender as Any,
            "isAvailable": isAvailable
        ]) { error in
            completion?(error)
        }
    }
    
    // Methodes suivantes ?
    
    
}
