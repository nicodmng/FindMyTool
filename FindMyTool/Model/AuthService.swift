//
//  AuthService.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 18/08/2022.
//

import Foundation
import Firebase


class AuthService {
    
    // MARK: - Methodes
    func isUserConnected() -> Bool {
       Auth.auth().currentUser != nil
    }
}
// End of class
