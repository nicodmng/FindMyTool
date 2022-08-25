//
//  AuthService.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 18/08/2022.
//

import Foundation
import FirebaseAuth


class AuthService {
    
    // MARK: - Methodes
    func isUserConnected() -> Bool {
       Auth.auth().currentUser != nil
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
