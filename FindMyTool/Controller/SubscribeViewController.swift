//
//  SubscribeViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 26/07/2022.
//

import UIKit
import FirebaseAuth

class SubscribeViewController: UIViewController {
    
    // MARK: IBOutlets & IBActions
    // IBOutlets
    @IBOutlet weak var usernameSubTextField: UITextField!
    @IBOutlet weak var emailSubTextField: UITextField!
    @IBOutlet weak var passwordSubTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    
    //IBActions
    @IBAction func subscribeButtonPressed(_ sender: Any) {
        if usernameSubTextField.text != "" && emailSubTextField.text != "" &&
            passwordSubTextField.text != "" {
            
            Auth.auth().createUser(withEmail: emailSubTextField.text!, password: passwordSubTextField.text!) { authResult, error in
                if error != nil {
                    print(error.debugDescription)
                } else {
                    print("Inscription de \(self.usernameSubTextField.text ?? "no name") réussie ✅ ")
                    // self.performSegue(withIdentifier: "goToHome", sender: self)
                }
            }
        }
    }
    
    @IBAction func backToLogInButtonPressed(_ sender: Any) {
        print("Retour à la page de connexion")
    }
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupTextFieldManager()
    }
    
    // MARK: - Private functions
    private func setupButton() {
        registerButton.layer.cornerRadius = 10
    }
    
    private func setupTextFieldManager() {
        usernameSubTextField.delegate = self
        emailSubTextField.delegate = self
        passwordSubTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    @objc private func hideKeyboard() {
        usernameSubTextField.resignFirstResponder()
        emailSubTextField.resignFirstResponder()
        passwordSubTextField.resignFirstResponder()
    }
    
}

// MARK: - Extensions
extension SubscribeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
