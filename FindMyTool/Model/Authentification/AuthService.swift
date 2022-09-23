//
//  AuthService.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 18/08/2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

class AuthService {
    
    // MARK: - Methodes
    func isUserConnected() -> Bool {
        Auth.auth().currentUser != nil
    }
    
    func getDocumentID() {
        let ref = Firestore.firestore().collection("tools")
        ref.getDocuments { querySnapshot, error in
            if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    let id = document.documentID
                    print(id)
                }
            }
        }
    }
    
    func getUserId(callback: @escaping (String) -> Void) {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            callback(uid)
        }
    }
    
    func fetchUserID() -> String {
        var userID = ""
        getUserId { uid in
            userID = uid
        }
        return userID
    }
    
    func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            //self.navigationController?.popToRootViewController(animated: true)
        } catch {
            //showAlert(message: "Impossible de se déconnecter.")
        }
    }
    
}
// End of class
