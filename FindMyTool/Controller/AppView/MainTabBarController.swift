//
//  MainTabBarController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 18/08/2022.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    private let authService: AuthService = AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if authService.isUserConnected() == false {
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "LogIn", bundle: nil)
                let signInViewController = storyboard.instantiateViewController(withIdentifier: "LogInViewController")
                signInViewController.modalPresentationStyle = .fullScreen
                self.present(signInViewController, animated: true)
            }
        } else { return }
    }
}


