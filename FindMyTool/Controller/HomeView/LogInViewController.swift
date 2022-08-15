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
            showAlert(message: "Merci de saisir un nom d'utilisateur et un mot de passe.")
        }
        
    }
    
    // MARK: - ViewDidLoad & ViewDidAppear
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupTextFieldManager()
    }
    
    // viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            // User is signed in.
            performSegue(withIdentifier: "goToSearchViewController", sender: self)
        } else {
            return
        }
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
// End of class

    // MARK: - Extensions
    extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
    }
        
}
// End of extension
