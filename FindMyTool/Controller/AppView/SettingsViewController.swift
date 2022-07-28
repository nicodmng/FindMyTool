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

    // MARK: - IBOutlets & IBActions
    // IBOutlets
    
    @IBOutlet weak var usernameTextField: UILabel!
    
    
    // IBActions
    @IBAction func logOutPressed(_ sender: UIButton) {
    logOut()
    print("Se déconnecter")
    }
    
    
    

    // MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        catchUsername()
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Functions
    func catchUsername() {
        if Auth.auth().currentUser != nil {
            let ref = Database.database().reference()
            let userID = Auth.auth().currentUser?.uid
            
            ref.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let username = value?["username"] as? String ?? "inconnu"
                
                self.usernameTextField.text = username
            }
        }
    }
    
    func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch {
          print("Impossible de déconnecter")
        }
    }

}
// End of class
