//
//  SubscribeViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 26/07/2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SubscribeViewController: UIViewController {
    
    // MARK: IBOutlets & IBActions
    // IBOutlets
    @IBOutlet weak var usernameSubTextField: UITextField!
    @IBOutlet weak var emailSubTextField: UITextField!
    @IBOutlet weak var passwordSubTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    //IBActions
    @IBAction func subscribeButtonPressed(_ sender: Any) {
        createUser()
    }
    
    @IBAction func backToLogInButtonPressed(_ sender: Any) {
        backToLogInPage()
    }
    
    @IBAction func backToLoginButtonCross(_ sender: Any) {
        backToLogInPage()
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
    
    private func backToLogInPage() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupTextFieldManager() {
        usernameSubTextField.delegate = self
        emailSubTextField.delegate = self
        passwordSubTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func createUser() {
        if usernameSubTextField.text != "" && emailSubTextField.text != "" &&
            passwordSubTextField.text != "" {
            Auth.auth().createUser(withEmail: emailSubTextField.text!, password: passwordSubTextField.text!) { authResult, error in
                if error != nil {
                    print(error.debugDescription)
                } else {
                    // Inscription du Username dans la BDD :
                    let ref = Database.database().reference()
                    let userID = Auth.auth().currentUser?.uid
                    ref.child("users").child(userID!).setValue(["username": self.usernameSubTextField.text!])
                    
                    self.showInformation(message: "Merci \(self.usernameSubTextField.text ?? ""). Votre compte a bien été enregistré.")
                }
            }
        } else {
            showAlert(message: "Merci de remplir tous les champs.")
        }
    }
    
    // MARK: - Actions
    @objc private func hideKeyboard() {
        usernameSubTextField.resignFirstResponder()
        emailSubTextField.resignFirstResponder()
        passwordSubTextField.resignFirstResponder()
    }
    
}
// End of class

// MARK: - Extensions
extension SubscribeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
// End of extension
