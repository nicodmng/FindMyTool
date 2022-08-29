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
    
    // MARK: - Initializer
    
    // MARK: - Methodes
    func displayUsername() {
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value) { snapshot in
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            print(username)
        }
    }
    
    func addToolInDatabase(name: String, price: String, localisation: String) {
        db.collection("tools").document(name).setData([
            "name" : name,
            "price" : price,
            "localisation" : localisation,
        ])
    }
    
    func getResultFromDatabase(name: String) {
        let toolRef = db.collection("tools").document(name)
        toolRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
}
