//
//  AuthService.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 18/08/2022.
//

import Foundation
import Firebase
import UIKit

class AuthService {
    
    // MARK: - Methodes
    func isUserConnected() -> Bool {
        if Auth.auth().currentUser != nil {
            return true
        } else {
            print("Disconnect")
            return false
        }
    }
    
}
// End of class
