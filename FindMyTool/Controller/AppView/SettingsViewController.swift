//
//  SettingsViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 27/07/2022.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SettingsViewController: UIViewController {

    // MARK: - Properties
    
    private let authService: AuthService = AuthService()
    private let authFirebase: AuthFirebase = AuthFirebase()
    
    // MARK: - IBOutlets & IBActions
    // IBOutlets
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    // IBActions
    @IBAction func logOutPressed(_ sender: UIButton) {
        authService.logOut()
    }
    
    // MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        authFirebase.displayUsername { username in
            self.usernameLabel.text = username 
        }
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions

}
// End of class
