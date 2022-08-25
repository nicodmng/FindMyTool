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
        //catchUsername()
        authFirebase.displayUsername()
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
//    func catchUsername() {
//        if Auth.auth().currentUser != nil {
//            let ref = Database.database().reference()
//            let userID = Auth.auth().currentUser?.uid
//
//            ref.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
//                let value = snapshot.value as? NSDictionary
//                let username = value?["username"] as? String ?? "inconnu"
//
//                self.usernameLabel.text = username
//            }
//        }
//    }

}
// End of class
