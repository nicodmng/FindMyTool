//
//  SettingsViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 27/07/2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let authFirebase: DatabaseService = DatabaseService()
    
    // MARK: - IBOutlets & IBActions

    // IBOutlets
    @IBOutlet weak var userMail: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    // IBActions
    @IBAction func logOutPressed(_ sender: UIButton) {
        authFirebase.logOut()
        let storyboard = UIStoryboard(name: "LogIn", bundle: nil)
        let logInViewController = storyboard.instantiateViewController(withIdentifier: "LogInViewController")
        logInViewController.modalPresentationStyle = .fullScreen
        self.present(logInViewController, animated: true)
    }
    
    @IBAction func contactSupportButton(_ sender: Any) {
        openPresentModally()
    }
    
    
    // MARK: - ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        authFirebase.displayUsername { username in
            self.usernameLabel.text = username
        }
        self.userMail.text = authFirebase.fetchUserEmail()
    }
    
    // MARK: - Methods
    
    // Display a medium modally
    func openPresentModally() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ContactSupportViewController")
        
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        self.present(viewController, animated: true)
    }
    
}

