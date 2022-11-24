//
//  MainTabBarController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 18/08/2022.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    private let auth: DatabaseService = DatabaseService()
    
    // Display LogInViewController if the user is not connected (false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if auth.isUserConnected() == false {
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "LogIn", bundle: nil)
                let signInViewController = storyboard.instantiateViewController(withIdentifier: "LogInViewController")
                signInViewController.modalPresentationStyle = .fullScreen
                self.present(signInViewController, animated: true)
            }
        }
    }
}
