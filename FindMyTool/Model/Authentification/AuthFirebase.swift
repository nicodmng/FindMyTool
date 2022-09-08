//
//  AuthFirebase.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 18/08/2022.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore


class AuthFirebase {
    // MARK: - Properties
    let db = Firestore.firestore()
    var tools = [Tools]()
    
    // MARK: - Initializer
    
    // MARK: - Methodes
    func displayUsername(callback: @escaping (String) -> Void) {
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value) { snapshot in
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            callback(username)
        }
    }
    
    func addToolInDatabase(idUser: String, name: String, price: String, localisation: String, town: String) {
        db.collection(idUser).document(name).setData([
            "name" : name,
            "price" : price,
            "localisation" : localisation,
            "town": town
        ])
    }
    
    func fetchTools(idUser: String) {
        db.collection(idUser).addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.tools = documents.compactMap { (queryDocumentSnapshot) -> Tools? in
                return try? queryDocumentSnapshot.data(as: Tools.self)
            }
        }
    }
    
}
