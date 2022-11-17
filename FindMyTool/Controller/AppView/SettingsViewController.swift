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
        
        // ToDo : Redirige vers la boîte e-mail de l'utilisateur
        
    }
    
    
    // MARK: - ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        authFirebase.displayUsername { username in
            self.usernameLabel.text = username
        }
        self.userMail.text = authFirebase.fetchUserEmail()
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

