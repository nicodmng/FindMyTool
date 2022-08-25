//
//  AuthFirebase.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 18/08/2022.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class AuthFirebase {
    
    // MARK: - Properties

    
    // MARK: - Initializer
    
    // MARK: - Methodes
//    func catchUsername(username: String) {
//        if Auth.auth().currentUser != nil {
//            var user = username
//            let ref = Database.database().reference()
//            let userID = Auth.auth().currentUser?.uid
//
//            ref.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
//                let value = snapshot.value as? NSDictionary
//                user = value?["username"] as? String ?? "inconnu"
//            }
//        }
//    }
    
    func displayUsername() {
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value) { snapshot in
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            print(username)
        }
    }
}
