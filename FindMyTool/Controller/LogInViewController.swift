//
//  ViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 25/07/2022.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {

    // MARK: - IBOutlets & IBActions
    // IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    //IBActions
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSubscribeViewController", sender: self)
    }
    
    @IBAction func logInButtonPressed(_ sender: Any) {
        if usernameTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (authResult, error) in
                if error != nil {
                    print(error.debugDescription)
                } else {
                    self.performSegue(withIdentifier: "goToSearchViewController", sender: self)
                }
            }
        } else {
            // afficher un alertController ici "Merci de remplir tous les champs" ou "MDP ou nom invalide"
            print("Pas OK")
        }
        
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupTextFieldManager()
    }
    
    // MARK: - Private functions
    private func setupButton() {
        logInButton.layer.cornerRadius = 10
    }
    
    private func setupTextFieldManager() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    @objc private func hideKeyboard() {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
}

    // MARK: - Extensions
    extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
    }
        
}

